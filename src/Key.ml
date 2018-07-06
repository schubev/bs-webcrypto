type 'alg t
type 'alg pair = { publicKey: 'alg t; privateKey: 'alg t }

type kind = 
	| Public
	| Private
	| Secret

let kindToJs = function
	| Public -> "public"
	| Private -> "private"
	| Secret -> "secret"

let kindFromJs = function
	| "public" -> Public
	| "private" -> Private
	| "secret" -> Secret
	| _ -> raise (invalid_arg "unknown value")

type usage =
	| Encrypt
	| Decrypt
	| Sign
	| Verify
	| DeriveKey
	| DeriveBits
	| WrapKey
	| UnwrapKey

let usageToJs = function
	| Encrypt -> "encrypt"
	| Decrypt -> "decrypt"
	| Sign -> "sign"
	| Verify -> "verify"
	| DeriveKey -> "deriveKey"
	| DeriveBits -> "deriveBits"
	| WrapKey -> "wrapKey"
	| UnwrapKey -> "unwrapKey"

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

external _kind : 'a t -> string = "type" [@@bs.get]
external _usage : 'a t -> string array = "usages" [@@bs.get]
let kind k = _kind k |> kindFromJs
let usage k = _usage k |> Array.map usageFromJs
