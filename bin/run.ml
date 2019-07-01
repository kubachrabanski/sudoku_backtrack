open Lib

let rec read_lines a =
    try read_lines ((read_line ()) :: a)
    with End_of_file -> List.rev a

let () =
    read_lines [] |> Sudoku.of_lines_string |> Backtrack.run |> Sudoku.print

