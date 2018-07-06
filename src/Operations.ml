open Js.Typed_array
open AlgorithmClass

module Make(I : Implementation.S) = struct
	let generateKey (type alg) (type par)
			(module A : KeyAlgorithm with type generateKeyParam = par and type t = alg)
			(param:par)
			?(extractable=false)
			usages
			: alg Key.t Js.Promise.t =
		I.generateKey (A.generateKeyParamToJs param) extractable (usages |> Array.map Key.usageToJs)
	;;

	let exportKey (type alg) (type fmt) 
			(module A : KeyAlgorithm with type t = alg)
			(module F : Export.S with type t = fmt)
			(key: alg Key.t)
			: (alg, fmt) Export.t Js.Promise.t =
		I.exportKey F.id key
	;;
	
	let importKey (type alg) (type fmt)
			(module A : KeyAlgorithm with type t = alg)
			(module F : Export.S with type t = fmt)
			(export: (alg, fmt) Export.t)
			: alg Key.t Js.Promise.t =
		I.exportKey F.id export
	;;

	let encrypt (type alg) (type par)
			(module A : EncryptionAlgorithm with type encryptionParam = par and type t = alg)
			(param:par)
			(key:alg Key.t)
			data
			: ArrayBuffer.t Js.Promise.t =
		I.encrypt (A.encryptionParamToJs param) key data
	;;

	let decrypt (type alg) (type par)
			(module A : EncryptionAlgorithm with type encryptionParam = par and type t = alg)
			(param:par)
			(key:alg Key.t)
			data
			: ArrayBuffer.t Js.Promise.t =
		I.decrypt (A.encryptionParamToJs param) key data
	;;

	let verify (type alg) (type par)
			(module A : SigningAlgorithm with type signingParam = par and type t = alg)
			(param:par)
			(key:alg Key.t)
			signature
			data
			: bool Js.Promise.t =
		I.verify (A.signingParamToJs param) key signature data
	;;

	let sign (type alg) (type par)
			(module A : SigningAlgorithm with type signingParam = par and type t = alg)
			(param:par)
			(key:alg Key.t)
			data
			: ArrayBuffer.t Js.Promise.t =
		I.sign (A.signingParamToJs param) key data
	;;

	let digest
			(module A : HashAlgorithm)
			: ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t =
		I.digest A.id

	module type TypedArray = sig
		type t
		val fromLength : int -> t
	end

	let getRandomValues (type b) (module B : TypedArray with type t = b) words =
		B.fromLength words |> I.getRandomValues

	let getRandomInt8Values = getRandomValues (module Int8Array)
	let getRandomUint8Values = getRandomValues (module Uint8Array)
	let getRandomUint8ClampedValues = getRandomValues (module Uint8ClampedArray)
	let getRandomInt16Values = getRandomValues (module Int16Array)
	let getRandomUint16Values = getRandomValues (module Uint16Array)
	let getRandomInt32Values = getRandomValues (module Int32Array)
	let getRandomUint32Values = getRandomValues (module Uint32Array)

	let fillRandomInt8Values : Int8Array.t -> Int8Array.t = I.getRandomValues
	let fillRandomUint8Values : Uint8Array.t -> Uint8Array.t = I.getRandomValues
	let fillRandomUint8ClampedValues : Uint8ClampedArray.t -> Uint8ClampedArray.t = I.getRandomValues
	let fillRandomInt16Values : Int16Array.t -> Int16Array.t = I.getRandomValues
	let fillRandomUint16Values : Uint16Array.t -> Uint16Array.t = I.getRandomValues
	let fillRandomInt32Values : Int32Array.t -> Int32Array.t = I.getRandomValues
	let fillRandomUint32Values : Uint32Array.t -> Uint32Array.t = I.getRandomValues
end
