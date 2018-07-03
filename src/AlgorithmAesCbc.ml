open Js.Typed_array

include AlgorithmAesMode.Make(struct
	type t
	let id = "AES-CBC"
	type encryptionParam = { initVector: ArrayBuffer.t; length: int }
	type encryptionParamJs = { iv: ArrayBuffer.t; length: int; name: string } [@@bs.deriving abstract]
	let encryptionParamToJs (p:encryptionParam) = encryptionParamJs ~length:p.length ~iv:p.initVector ~name:id
end)
