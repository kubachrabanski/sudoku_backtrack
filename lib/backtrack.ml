open Aux

let rec backtrack sudoku heuristic =
    let index = Heuristic.next sudoku heuristic in
    Hashset.iter (fun value ->
        Sudoku.set sudoku index value;
        let indexes = Heuristic.remove_option heuristic index value in
        backtrack sudoku heuristic;
        Sudoku.unset sudoku index;
        Heuristic.add_option heuristic indexes value) (Heuristic.get_options heuristic index)

let run sudoku =
    let heuristic = Heuristic.create sudoku in
    try backtrack sudoku heuristic; raise Heuristic.NoSolution
    with Heuristic.Solution -> sudoku

