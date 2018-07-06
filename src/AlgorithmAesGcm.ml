open Js.Typed_array

type t
let id = "AES-GCM"

type generateKeyParam = { length: int }
type generateKeyResult = t Key.t
type generateKeyParamJs = { length: int; name:string } [@@bs.deriving abstract]
let generateKeyParamToJs (p:generateKeyParam) = generateKeyParamJs ~length:p.length ~name:id

type encryptionParam = { initVector: ArrayBuffer.t; authData: ArrayBuffer.t; length: int }
type encryptionParamJs = { iv: ArrayBuffer.t; additionalData: ArrayBuffer.t; length: int; name: string } [@@bs.deriving abstract]
let encryptionParamToJs (p:encryptionParam) = encryptionParamJs ~length:p.length ~iv:p.initVector ~additionalData:p.authData ~name:id
