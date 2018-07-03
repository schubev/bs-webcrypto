open Js.Typed_array

include AlgorithmAesMode.Make(struct
	type t
	let id = "AES-CTR"
	type encryptionParam = { counter: ArrayBuffer.t; length: int }
	type encryptionParamJs = { counter: ArrayBuffer.t; length: int; name: string } [@@bs.deriving abstract]
	let encryptionParamToJs (p:encryptionParam) = encryptionParamJs ~length:p.length ~counter:p.counter ~name:id
end)
