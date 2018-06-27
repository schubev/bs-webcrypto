open Js.Typed_array

let id = "RSA-OAEP"
type t

type generateKeyParam = (module AlgorithmClass.HashAlgorithm)
type generateKeyResult = t CryptoKey.pair
type encryptionParam = { label: ArrayBuffer.t option }

type generateKeyParamJs = { name: string } [@@bs.deriving abstract]
let generateKeyParamToJs (module H : AlgorithmClass.HashAlgorithm) = generateKeyParamJs ~name:H.id

type encryptionParamJs = { label: ArrayBuffer.t Js.Undefined.t } [@@bs.deriving abstract]
let encryptionParamToJs (param:encryptionParam) = encryptionParamJs ~label:(Js.Undefined.fromOption param.label)
