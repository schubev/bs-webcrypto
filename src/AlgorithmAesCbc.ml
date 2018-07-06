open Js.Typed_array

type t
let id = "AES-CBC"

type generateKeyParam = { length: int }
type generateKeyResult = t CryptoKey.t
type generateKeyParamJs = { length: int; name:string } [@@bs.deriving abstract]
let generateKeyParamToJs (p:generateKeyParam) = generateKeyParamJs ~length:p.length ~name:id

type encryptionParam = { initVector: ArrayBuffer.t }
type encryptionParamJs = { iv: ArrayBuffer.t; name: string } [@@bs.deriving abstract]
let encryptionParamToJs (p:encryptionParam) = encryptionParamJs ~iv:p.initVector ~name:id
