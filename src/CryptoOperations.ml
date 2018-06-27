open Js.Typed_array
open CryptoBase
open CryptoAlgorithmClass

external generateKey_ : subtle -> 'p -> extractable:bool -> string array -> 'k Js.Promise.t = "generateKey" [@@bs.send]
let generateKey (type alg) (type par) crypto (module A : KeyAlgorithm with type generateKeyParam = par and type t = alg) (param:par) ?(extractable=false) usages : alg CryptoKey.t Js.Promise.t =
	generateKey_ crypto (A.generateKeyParamToJs param) extractable (usages |> Array.map CryptoKey.usageToJs)
;;

external exportKey_ : subtle -> string -> 'k -> 'e Js.Promise.t = "exportKey" [@@bs.send]
let exportKey (type alg) (type fmt) crypto (module A : KeyAlgorithm with type t = alg) (module F : CryptoKey.Format with type t = fmt) (key: alg CryptoKey.t) : (alg, fmt) CryptoKey.export Js.Promise.t =
	exportKey_ crypto F.id key
;;

external importKey_ : subtle -> string -> 'e -> 'k Js.Promise.t = "importKey" [@@bs.send]
let importKey (type alg) (type fmt) crypto (module A : KeyAlgorithm with type t = alg) (module F : CryptoKey.Format with type t = fmt) (export: (alg, fmt) CryptoKey.export) : alg CryptoKey.t Js.Promise.t =
	exportKey_ crypto F.id export
;;

external encrypt_ : subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "encrypt" [@@bs.send]
let encrypt (type alg) (type par) crypto (module A : EncryptionAlgorithm with type encryptionParam = par and type t = alg) (param:par) (key:alg CryptoKey.t) data =
	encrypt_ crypto (A.encryptionParamToJs param) key data
;;

external decrypt_ : subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "decrypt" [@@bs.send]
let decrypt (type alg) (type par) crypto (module A : EncryptionAlgorithm with type encryptionParam = par and type t = alg) (param:par) (key:alg CryptoKey.t) data =
	decrypt_ crypto (A.encryptionParamToJs param) key data
;;

external verify_ : subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t -> Js.boolean Js.Promise.t = "verify" [@@bs.send]
let verify (type alg) (type par) crypto (module A : SigningAlgorithm with type signingParam = par and type t = alg) (param:par) (key:alg CryptoKey.t) signature data =
	let open Js.Promise in
	verify_ crypto (A.signingParamToJs param) key signature data |> then_(fun r -> Js.to_bool r |> resolve)
;;

external sign_ : subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "sign" [@@bs.send]
let sign (type alg) (type par) crypto (module A : SigningAlgorithm with type signingParam = par and type t = alg) (param:par) (key:alg CryptoKey.t) data =
	sign_ crypto (A.signingParamToJs param) key data
;;

external digest_ : subtle -> string -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "digest" [@@bs.send]
let digest (type alg) crypto (module A : HashAlgorithm with type t = alg) = digest_ crypto A.id
