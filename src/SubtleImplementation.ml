open Js.Typed_array

module type Subtle = sig
	type crypto
	type subtle

	val crypto : crypto
	val subtle : subtle
end

(*
module WebSubtle : Subtle = struct
	type crypto
	type subtle

	external crypto : crypto = "window.crypto" [@@bs.val]
	external getSubtle : crypto -> subtle = "subtle" [@@bs.get]
	let subtle = crypto |> getSubtle
end
*)

module NodeSubtle : Subtle = struct
	type crypto
	type subtle

	external newCrypto : unit -> crypto = "node-webcrypto-ossl" [@@bs.module][@@bs.new]
	external getSubtle : crypto -> subtle = "subtle" [@@bs.get]
	let crypto = newCrypto ()
	let subtle = crypto |> getSubtle
end

module Make(S: Subtle) = struct
	external generateKey_ : S.subtle -> 'p -> bool -> string array -> 'k Js.Promise.t = "generateKey" [@@bs.send]
	external exportKey_ : S.subtle -> string -> 'k -> 'e Js.Promise.t = "exportKey" [@@bs.send]
	external importKey_ : S.subtle -> string -> 'e -> 'k Js.Promise.t = "importKey" [@@bs.send]
	external encrypt_ : S.subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "encrypt" [@@bs.send]
	external decrypt_ : S.subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "decrypt" [@@bs.send]
	external verify_ : S.subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t -> bool Js.Promise.t = "verify" [@@bs.send]
	external sign_ : S.subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "sign" [@@bs.send]
	external digest_ : S.subtle -> string -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "digest" [@@bs.send]
	external getRandomValues_ : S.crypto -> 'buffer -> 'buffer = "getRandomValues" [@@bs.send]

	let generateKey (parameters:'parameters) (extractable:bool) (capabilities:string array) = generateKey_ S.subtle parameters extractable capabilities
	let exportKey format key = exportKey_ S.subtle format key
	let importKey format export = importKey_ S.subtle format export
	let encrypt parameters key plaintext = encrypt_ S.subtle parameters key plaintext
	let decrypt parameters key ciphertext = decrypt_ S.subtle parameters key ciphertext
	let verify parameters key data signature = verify_ S.subtle parameters key data signature
	let sign parameters key data = sign_ S.subtle parameters key data
	let digest = digest_ S.subtle
	let getRandomValues buffer = getRandomValues_ S.crypto buffer
end
