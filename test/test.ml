open OUnit2

let suite =
    "suite" >::: [
        "test" >:: (fun _ -> print_endline "test")
    ]

let () =
    run_test_tt_main suite
