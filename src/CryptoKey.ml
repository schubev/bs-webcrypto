type 'alg t
type 'alg pair = { publicKey: 'alg t; privateKey: 'alg t }
type ('alg, 'fmt) export

module type Format = sig
	val id : string
	type t
end

module Format = struct
	module Raw = (CryptoKeyFormatRaw : Format)
end

type format = Raw | Spki | Pkcs8 | Jwk ;;
let formatToJs = function
	| Raw -> "raw"
	| Spki -> "spki"
	| Pkcs8 -> "pkcs8"
	| Jwk -> "jwk"
;;
let formatFromJs = function
	| "raw" -> Raw
	| "spki" -> Spki
	| "pkcs8" -> Pkcs8
	| "jwk" -> Jwk
	| _ -> raise (invalid_arg "unknown value")
;;

type kind = Public | Private | Secret ;;
let kindToJs = function
	| Public -> "public"
	| Private -> "private"
	| Secret -> "secret"
;;
let kindFromJs = function
	| "public" -> Public
	| "private" -> Private
	| "secret" -> Secret
	| _ -> raise (invalid_arg "unknown value")
;;

type usage = Encrypt | Decrypt | Sign | Verify | DeriveKey | DeriveBits | WrapKey | UnwrapKey ;;
let usageToJs = function
	| Encrypt -> "encrypt"
	| Decrypt -> "decrypt"
	| Sign -> "sign"
	| Verify -> "verify"
	| DeriveKey -> "deriveKey"
	| DeriveBits -> "deriveBits"
	| WrapKey -> "wrapKey"
	| UnwrapKey -> "unwrapKey"
;;
let usageFromJs = function
	| "encrypt" -> Encrypt
	| "decrypt" -> Decrypt
	| "sign" -> Sign
	| "verify" -> Verify
	| "deriveKey" -> DeriveKey
	| "deriveBits" -> DeriveBits
	| "wrapKey" -> WrapKey
	| "unwrapKey" -> UnwrapKey
	| _ -> raise (invalid_arg "unknown value")
;;

external _kind : 'a t -> string = "type" [@@bs.get]
external _usage : 'a t -> string array = "usages" [@@bs.get]
let kind k = _kind k |> kindFromJs
let usage k = _usage k |> Array.map usageFromJs
