open Jest
;;

describe "Addition" (fun () -> (
	let open Expect in

	test "Neutral element" (fun () -> (
		expect (4 + 0) |> toBe 4
	));
	
	test "Failure" (fun () -> (
		expect (4 + 0) |> toBe 5
	))
))
;;
