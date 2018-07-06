open Js.Typed_array

type t
let id = "raw"

let buffer : ('alg, t) KeyExport.t -> ArrayBuffer.t = Obj.magic
