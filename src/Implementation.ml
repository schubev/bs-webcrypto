open Js.Typed_array

module type S = sig
	val generateKey : 'parameters -> ?extractable:bool -> string array -> 'key Js.Promise.t
	val exportKey : string -> 'key -> 'export Js.Promise.t
	val importKey : string -> 'export -> 'key Js.Promise.t
	val encrypt : 'parameter -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t
	val decrypt : 'parameter -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t
	val verify : 'parameter -> 'key -> ArrayBuffer.t -> ArrayBuffer.t -> bool Js.Promise.t
	val sign : 'parameter -> 'key -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t
	val digest : string -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t
	val getRandomValues : 'buffer -> 'buffer
end

module Subtle : S = Subtle