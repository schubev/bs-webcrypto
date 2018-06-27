open Js.Typed_array

module type CryptoImplementation = sig
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

type crypto
type subtle

val crypto : crypto
val subtle : subtle

module Random : sig
	val getRandomUint8Values : crypto -> Uint8Array.t -> Uint8Array.t
	val getRandomUint8ClampedValues : crypto -> Uint8ClampedArray.t -> Uint8ClampedArray.t
	val getRandomUint16Values : crypto -> Uint16Array.t -> Uint16Array.t
	val getRandomUint32Values : crypto -> Uint32Array.t -> Uint32Array.t
	val getRandomInt8Values : crypto -> Int8Array.t -> Int8Array.t
	val getRandomInt16Values : crypto -> Int16Array.t -> Int16Array.t
	val getRandomInt32Values : crypto -> Int32Array.t -> Int32Array.t
end

module Key : sig
	type 'alg t
	type 'alg pair = { publicKey: 'alg t; privateKey: 'alg t }
	type ('fmt, 'alg) export
	type usage = Encrypt | Decrypt | Sign | Verify | DeriveKey | DeriveBits | WrapKey | UnwrapKey ;;
	type kind = Public | Private | Secret ;;

	val usage : 'a t -> usage array
	val kind : 'a t -> kind

	val usageToJs : usage -> string
	val usageFromJs : string -> usage
	val kindToJs : kind -> string
	val kindFromJs : string -> kind

	module type Format = sig
		val id : string
		type t
	end
end

module Algorithm : sig
	module Class : sig
		module type Algorithm = sig
			val id : string
			type t
		end

		module type KeyAlgorithm = sig
			include Algorithm
			type generateKeyParam
			type generateKeyResult

			type generateKeyParamJs
			val generateKeyParamToJs : generateKeyParam -> generateKeyParamJs
		end

		module type EncryptionAlgorithm = sig
			include KeyAlgorithm
			type encryptionParam

			type encryptionParamJs
			val encryptionParamToJs : encryptionParam -> encryptionParamJs
		end

		module type SigningAlgorithm = sig
			include KeyAlgorithm
			type signingParam

			type signingParamJs
			val signingParamToJs : signingParam -> signingParamJs
		end

		module type HashAlgorithm = sig
			include Algorithm

			val digestSize : int
		end

		module type BitDerivationAlgorithm = sig
			include Algorithm
			type bitDerivationParam

			type bitDerivationParamJs
			val bitDerivationParamToJs : bitDerivationParam -> bitDerivationParamJs
		end

		module type KeyDerivationAlgorithm = sig
			include Algorithm
			type keyDerivationParam

			type keyDerivationParamJs
			val keyDerivationParamToJs : keyDerivationParam -> keyDerivationParamJs
		end
	end
	open Class
	module AesCtr : EncryptionAlgorithm
	module RsaPss : SigningAlgorithm
	module RsaOaep : EncryptionAlgorithm
	(*module Pbkdf2 : BitDerivationAlgorithm*)
	module Sha1 : HashAlgorithm
	module Sha256 : HashAlgorithm
	module Sha384 : HashAlgorithm
	module Sha512 : HashAlgorithm
end
open Algorithm.Class

module Helper : sig
	val mod3 : Uint8Array.t
	val mod65535 : Uint8Array.t
end

val generateKey : subtle -> (module KeyAlgorithm with type generateKeyParam = 'p and type t = 'alg) -> 'p -> ?extractable:bool -> Key.usage array -> 'alg Key.t Js.Promise.t
val exportKey : subtle -> (module KeyAlgorithm with type t = 'alg) -> (module Key.Format with type t = 'fmt) -> 'alg Key.t -> ('alg, 'fmt) Key.export Js.Promise.t
val importKey : subtle -> (module KeyAlgorithm with type t = 'alg) -> (module Key.Format with type t = 'fmt) -> ('alg, 'fmt) Key.export -> 'alg Key.t Js.Promise.t
val encrypt : subtle -> (module EncryptionAlgorithm with type encryptionParam = 'p and type t = 'alg) -> 'p -> 'alg Key.t -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t
val decrypt : subtle -> (module EncryptionAlgorithm with type encryptionParam = 'p and type t = 'alg) -> 'p -> 'alg Key.t -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t
val sign : subtle -> (module SigningAlgorithm with type signingParam = 'p and type t = 'alg) -> 'p -> 'alg Key.t -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t
val verify : subtle -> (module SigningAlgorithm with type signingParam = 'p and type t = 'alg) -> 'p -> 'alg Key.t -> ArrayBuffer.t -> ArrayBuffer.t -> bool Js.Promise.t
val digest : subtle -> (module HashAlgorithm with type t = 'alg) -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t
