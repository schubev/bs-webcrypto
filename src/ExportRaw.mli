open Js.Typed_array

type t
val id : string

val buffer : ('alg, t) Export.t -> ArrayBuffer.t
