open Js.Promise

let (>>=) (a:'a Js.Promise.t) (f:'a -> 'b Js.Promise.t) : 'b Js.Promise.t = a |> then_ f
let (>|=) (a:'a Js.Promise.t) (f:'a -> 'b) : 'b Js.Promise.t = a >>= (fun x -> resolve @@ f x)
