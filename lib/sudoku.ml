open Aux

let rec int_sqrt n =
    if n = 0 then 0 else
        let r1 = 2 * (int_sqrt (n / 4)) in
        let r2 = r1 + 1 in
        if n < (r2 * r2) then r1 else r2

let int_flat k n = (k / n) * n

let int_digits n = int_of_float (log10 (float n)) + 1


type t = {
    grid : (int array) array;
    size : int;
    sub_size : int
}

let create grid =
    let size = Array.length grid in
    let sub_size = int_sqrt size in assert (sub_size * sub_size = size);
    { grid; size; sub_size }

let empty size =
    let sub_size = int_sqrt size in assert (sub_size * sub_size = size);
    { grid = Array.make_matrix size size 0; size; sub_size } 

let get sudoku (i, j) =
    sudoku.grid.(i).(j)

let set sudoku (i, j) value =
    sudoku.grid.(i).(j) <- value

let unset sudoku (i, j) =
    set sudoku (i, j) 0

let is_unset sudoku (i, j) = 
    sudoku.grid.(i).(j) = 0

let size sudoku = sudoku.size

let sub_size sudoku = sudoku.sub_size


let indexes sudoku (i, j) =
    let x = int_flat i sudoku.sub_size and y = int_flat j sudoku.sub_size in
    let xn = x + sudoku.sub_size and yn = y + sudoku.sub_size in
    let rec column_indexes k kn a =
        if k < kn then
            if k < x || k > xn - 1 then column_indexes (k + 1) kn ((k, j) :: a)
            else column_indexes (k + 1) kn a
        else a
    in
    let rec row_indexes k kn a =
        if k < kn then
            if k < y || k > yn - 1 then row_indexes (k + 1) kn ((i, k) :: a)
            else row_indexes (k + 1) kn a
        else a
    in
    let sub_indexes x y xn yn a = (* to be fixed *)
        let a = ref a in
        for i = x to xn - 1 do
            for j = y to yn - 1 do
                a := (i, j) :: !a
            done;
        done; !a
    in
    column_indexes 0 sudoku.size [] |> row_indexes 0 sudoku.size |>
        sub_indexes x y xn yn

let options sudoku indexes =
    let values = Hashset.init sudoku.size (fun i -> i + 1) in
    List.iter (fun (i, j) ->
        let value = sudoku.grid.(i).(j) in
        if value <> 0 then (Hashset.remove values value)) indexes;
        values

let of_lines_string lines =
    List.map (fun line -> Str.split (Str.regexp " +") (String.trim line) |>
        List.map int_of_string |> Array.of_list) lines |>
    Array.of_list |> create

let of_string data =
    String.split_on_char '\n' data |> of_lines_string

let read file =
    let rec read_lines ic a =
        try read_lines ic ((input_line ic) :: a)
        with End_of_file -> close_in ic; List.rev a
    in
    read_lines (open_in file) [] |> of_lines_string

let to_string sudoku =
    let digits = int_digits sudoku.size in
    let buffer = Buffer.create (((digits + 1) * sudoku.size + 1) * sudoku.size) in
    let padding spot =
        Buffer.add_string buffer spot;
        for _ = 1 to digits - String.length spot + 1 do
            Buffer.add_char buffer ' '
        done
    in
    Array.iter (fun line ->
        List.iter (fun spot -> padding (string_of_int spot)) (Array.to_list line);
        Buffer.add_char buffer '\n') sudoku.grid;
    Buffer.contents buffer

let write file sudoku =
    let oc = open_out file in
    output_string oc (to_string sudoku);
    close_out oc

let print sudoku =
    print_endline (to_string sudoku)

