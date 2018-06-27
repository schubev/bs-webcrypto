let id = "RSA-PSS"
type t

type generateKeyParam = (module CryptoAlgorithmClass.HashAlgorithm)
type generateKeyResult = t CryptoKey.pair
type signingParam = { saltLength: int }

type generateKeyParamJs = { name: string } [@@bs.deriving abstract]
let generateKeyParamToJs (module H : CryptoAlgorithmClass.HashAlgorithm) = generateKeyParamJs ~name:H.id

type signingParamJs = { saltLength: int } [@@bs.deriving abstract]
let signingParamToJs (param:signingParam) = signingParamJs ~saltLength:param.saltLength
