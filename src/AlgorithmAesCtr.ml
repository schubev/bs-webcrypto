open Js.Typed_array

type t
let id = "AES-CTR"

type generateKeyParam = { length: int }
type generateKeyResult = t CryptoKey.t
type generateKeyParamJs = { length: int; name:string } [@@bs.deriving abstract]
let generateKeyParamToJs (p:generateKeyParam) = generateKeyParamJs ~length:p.length ~name:id

type encryptionParam = { counter: ArrayBuffer.t; length: int }
type encryptionParamJs = { counter: ArrayBuffer.t; length: int; name: string } [@@bs.deriving abstract]
let encryptionParamToJs (p:encryptionParam) = encryptionParamJs ~length:p.length ~counter:p.counter ~name:id
