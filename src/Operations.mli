open Js
open Js.Typed_array
open AlgorithmClass

module Make(I : Implementation.S) : sig
	val generateKey : (module KeyAlgorithm with type t = 'alg and type generateKeyParam = 'par) -> 'par -> ?extractable:bool -> Key.usage array -> 'alg Key.t Promise.t
	val exportKey : (module KeyAlgorithm with type t = 'alg) -> (module Export.S with type t = 'fmt) -> 'alg Key.t -> ('alg, 'fmt) Export.t Promise.t
	val importKey : (module KeyAlgorithm with type t = 'alg) -> (module Export.S with type t = 'fmt) -> ('alg, 'fmt) Export.t -> 'alg Key.t Promise.t
	val encrypt : (module EncryptionAlgorithm with type t = 'alg and type encryptionParam = 'par) -> 'par -> 'alg Key.t -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
	val decrypt : (module EncryptionAlgorithm with type t = 'alg and type encryptionParam = 'par) -> 'par -> 'alg Key.t -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
	val verify : (module SigningAlgorithm with type t = 'alg and type signingParam = 'par) -> 'par -> 'alg Key.t -> ArrayBuffer.t -> ArrayBuffer.t -> bool Promise.t
	val sign : (module SigningAlgorithm with type t = 'alg and type signingParam = 'par) -> 'par -> 'alg Key.t -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
	val digest : (module HashAlgorithm) -> ArrayBuffer.t -> ArrayBuffer.t Promise.t
	val getRandomInt8Values : int -> Int8Array.t
	val getRandomUint8Values : int -> Uint8Array.t
	val getRandomUint8ClampedValues : int -> Uint8ClampedArray.t
	val getRandomInt16Values : int -> Int16Array.t
	val getRandomUint16Values : int -> Uint16Array.t
	val getRandomInt32Values : int -> Int32Array.t
	val getRandomUint32Values : int -> Uint32Array.t
	val fillRandomInt8Values : Int8Array.t -> Int8Array.t
	val fillRandomUint8Values : Uint8Array.t -> Uint8Array.t
	val fillRandomUint8ClampedValues : Uint8ClampedArray.t -> Uint8ClampedArray.t
	val fillRandomInt16Values : Int16Array.t -> Int16Array.t
	val fillRandomUint16Values : Uint16Array.t -> Uint16Array.t
	val fillRandomInt32Values : Int32Array.t -> Int32Array.t
	val fillRandomUint32Values : Uint32Array.t -> Uint32Array.t
end
