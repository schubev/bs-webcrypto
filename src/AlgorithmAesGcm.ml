open Js.Typed_array

include AlgorithmAesMode.Make(struct
	type t
	let id = "AES-GCM"
	type encryptionParam = { initVector: ArrayBuffer.t; authData: ArrayBuffer.t; length: int }
	type encryptionParamJs = { iv: ArrayBuffer.t; additionalData: ArrayBuffer.t; length: int; name: string } [@@bs.deriving abstract]
	let encryptionParamToJs (p:encryptionParam) = encryptionParamJs ~length:p.length ~iv:p.initVector ~additionalData:p.authData ~name:id
end)