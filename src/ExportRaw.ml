open Js.Typed_array

type t
let id = "raw"

let buffer : ('alg, t) Export.t -> ArrayBuffer.t = Obj.magic
