let id = "RSA-PSS"
type t

type generateKeyParam = (module AlgorithmClass.HashAlgorithm)
type generateKeyResult = t Key.pair
type signingParam = { saltLength: int }

type generateKeyParamJs = { name: string } [@@bs.deriving abstract]
let generateKeyParamToJs (module H : AlgorithmClass.HashAlgorithm) = generateKeyParamJs ~name:H.id

type signingParamJs = { saltLength: int } [@@bs.deriving abstract]
let signingParamToJs (param:signingParam) = signingParamJs ~saltLength:param.saltLength
