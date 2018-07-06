open Js.Typed_array
open Js

module type S = sig
	val generateKey : 'parameters -> bool -> string array -> 'key Promise.t
	val exportKey : string -> 'key -> 'export Promise.t
	val importKey : string -> 'export -> 'key Promise.t
	val encrypt : 'parameter -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
	val decrypt : 'parameter -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
	val verify : 'parameter -> 'key -> ArrayBuffer.t -> ArrayBuffer.t -> bool Promise.t
	val sign : 'parameter -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
	val digest : string -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
	val getRandomValues : 'buffer -> 'buffer
end
