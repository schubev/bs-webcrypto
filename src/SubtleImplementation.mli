open Js
open Js.Typed_array

val generateKey : 'param -> bool -> string array -> 'key Promise.t
val exportKey : string -> 'key -> 'export Promise.t
val importKey : string -> 'export -> 'key Promise.t
val encrypt : 'param -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
val decrypt : 'param -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
val verify : 'param -> 'key -> ArrayBuffer.t -> ArrayBuffer.t -> bool Promise.t
val sign : 'param -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
val digest : string -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
val getRandomValues : 'buffer -> 'buffer
