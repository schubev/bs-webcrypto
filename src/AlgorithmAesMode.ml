module type Mode = sig
	type t
	val id : string

	type encryptionParam
	type encryptionParamJs
	val encryptionParamToJs : encryptionParam -> encryptionParamJs
end

module Make(M: Mode) = struct
	include M

	type generateKeyParam = { length: int }
	type generateKeyResult = t CryptoKey.t
	type generateKeyParamJs = { length: int; name:string } [@@bs.deriving abstract]
	let generateKeyParamToJs (p:generateKeyParam) = generateKeyParamJs ~length:p.length ~name:id
end