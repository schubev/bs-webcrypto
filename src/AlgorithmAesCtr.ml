open Js.Typed_array

let id = "AES-CTR"
type t

type generateKeyParam = { length: int }
type generateKeyResult = t CryptoKey.t
type encryptionParam = { counter: ArrayBuffer.t; length: int }

type generateKeyParamJs = { length: int; name:string } [@@bs.deriving abstract]
let generateKeyParamToJs (p:generateKeyParam) = generateKeyParamJs ~length:p.length ~name:id
type encryptionParamJs = { counter: ArrayBuffer.t; length: int; name: string } [@@bs.deriving abstract]
let encryptionParamToJs (p:encryptionParam) = encryptionParamJs ~length:p.length ~counter:p.counter ~name:id
