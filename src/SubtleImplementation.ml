open Js.Typed_array

type crypto
type subtle

external crypto : crypto = "window.crypto" [@@bs.val]
external getSubtle : crypto -> subtle = "subtle" [@@bs.get]
let subtle = crypto |> getSubtle

external generateKey_ : subtle -> 'p -> bool -> string array -> 'k Js.Promise.t = "generateKey" [@@bs.send]
external exportKey_ : subtle -> string -> 'k -> 'e Js.Promise.t = "exportKey" [@@bs.send]
external importKey_ : subtle -> string -> 'e -> 'k Js.Promise.t = "importKey" [@@bs.send]
external encrypt_ : subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "encrypt" [@@bs.send]
external decrypt_ : subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "decrypt" [@@bs.send]
external verify_ : subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t -> bool Js.Promise.t = "verify" [@@bs.send]
external sign_ : subtle -> 'p -> 'k -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "sign" [@@bs.send]
external digest_ : subtle -> string -> ArrayBuffer.t -> ArrayBuffer.t Js.Promise.t = "digest" [@@bs.send]
external getRandomValues_ : crypto -> 'buffer -> 'buffer = "getRandomValues" [@@bs.send]

let generateKey parameters ?(extractable=false) capabilities = generateKey_ subtle parameters extractable capabilities
let exportKey format key = exportKey_ subtle format key
let importKey format export = importKey_ subtle format export
let encrypt parameters key plaintext = encrypt_ subtle parameters key plaintext
let decrypt parameters key ciphertext = decrypt_ subtle parameters key ciphertext
let verify parameters key data signature = verify_ subtle parameters key data signature
let sign parameters key data = sign_ subtle parameters key data
let digest = digest_ subtle
let getRandomValues buffer = getRandomValues_ crypto buffer
