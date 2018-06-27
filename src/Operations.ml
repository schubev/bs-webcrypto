open Js.Typed_array
open CryptoAlgorithmClass

module Make(I : Implementation.S) = struct
	let generateKey (type alg) (type par)
			(module A : KeyAlgorithm with type generateKeyParam = par and type t = alg)
			(param:par)
			?(extractable=false)
			usages
			: alg CryptoKey.t Js.Promise.t =
		I.generateKey (A.generateKeyParamToJs param) extractable (usages |> Array.map CryptoKey.usageToJs)
	;;

	let exportKey (type alg) (type fmt) 
			(module A : KeyAlgorithm with type t = alg)
			(module F : CryptoKey.Format with type t = fmt)
			(key: alg CryptoKey.t)
			: (alg, fmt) CryptoKey.export Js.Promise.t =
		I.exportKey F.id key
	;;
	
	let importKey (type alg) (type fmt)
			(module A : KeyAlgorithm with type t = alg)
			(module F : CryptoKey.Format with type t = fmt)
			(export: (alg, fmt) CryptoKey.export)
			: alg CryptoKey.t Js.Promise.t =
		I.exportKey F.id export
	;;

	let encrypt (type alg) (type par)
			(module A : EncryptionAlgorithm with type encryptionParam = par and type t = alg)
			(param:par)
			(key:alg CryptoKey.t)
			data
			: ArrayBuffer.t Js.Promise.t =
		I.encrypt (A.encryptionParamToJs param) key data
	;;

	let decrypt (type alg) (type par)
			(module A : EncryptionAlgorithm with type encryptionParam = par and type t = alg)
			(param:par)
			(key:alg CryptoKey.t)
			data
			: ArrayBuffer.t Js.Promise.t =
		I.decrypt (A.encryptionParamToJs param) key data
	;;

	let verify (type alg) (type par)
			(module A : SigningAlgorithm with type signingParam = par and type t = alg)
			(param:par)
			(key:alg CryptoKey.t)
			signature
			data
			: bool Js.Promise.t =
		I.verify (A.signingParamToJs param) key signature data
	;;

	let sign (type alg) (type par)
			(module A : SigningAlgorithm with type signingParam = par and type t = alg)
			(param:par)
			(key:alg CryptoKey.t)
			data
			: ArrayBuffer.t Js.Promise.t =
		I.sign (A.signingParamToJs param) key data
	;;

	let digest (type alg)
			(module A : HashAlgorithm with type t = alg)
			: ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t =
		I.digest A.id
end
