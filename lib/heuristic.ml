open Aux

type t = {
    options : ((int Hashset.t) array) array;
    indexes : (((int * int) list) array) array;
}

exception Solution
exception NoSolution

let create sudoku =
    let size = Sudoku.size sudoku in
    let indexes = Array.make_matrix size size [] in
    let options = Array.make_matrix size size (Hashset.empty ()) in
    for i = 0 to Sudoku.size sudoku - 1 do
        for j = 0 to Sudoku.size sudoku - 1 do
            if Sudoku.is_unset sudoku (i, j) then begin
                indexes.(i).(j) <- Sudoku.indexes sudoku (i, j);
                options.(i).(j) <- Sudoku.options sudoku indexes.(i).(j)
            end
        done;
    done; { options; indexes }

let next sudoku heuristic = (* to be fixed *)
    let p = ref (-1, -1) in
    let b = ref (Sudoku.size sudoku + 1) in
    for i = 0 to Sudoku.size sudoku - 1 do
        for j = 0 to Sudoku.size sudoku - 1 do
            if Sudoku.is_unset sudoku (i, j) && Hashset.length (heuristic.options.(i).(j)) < !b then begin
                b := Hashset.length (heuristic.options.(i).(j));
                p := (i, j)
            end
        done;
    done;
    if !p = (-1, -1) then raise Solution else !p

let get_options heuristic (i, j) =
    heuristic.options.(i).(j)

let add_option heuristic indexes value =
    List.iter (fun (x, y) ->
        Hashset.add heuristic.options.(x).(y) value) indexes

let remove_option heuristic (i, j) value = (* to be fixed *)
    let rec aux l a = match l with
        | [] -> a
        | (x, y) :: t ->
            if Hashset.mem heuristic.options.(x).(y) value then begin
                Hashset.remove heuristic.options.(x).(y) value;
                aux t ((x, y) :: a) end
            else aux t a
    in aux heuristic.indexes.(i).(j) []

   