type 'alg t
type 'alg pair = { publicKey: 'alg t; privateKey: 'alg t }

type kind =
	| Public
	| Private
	| Secret

val kindToJs : kind -> string
val kindFromJs : string -> kind

type usage =
	| Encrypt
	| Decrypt
	| Sign
	| Verify
	| DeriveKey
	| DeriveBits
	| WrapKey
	| UnwrapKey

val usageToJs : usage -> string
val usageFromJs : string -> usage

val kind : 'alg t -> kind
val usage : 'alg t -> usage array
