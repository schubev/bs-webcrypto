let id = "ECDSA"
type t

type curve =
| P256
| P384
| P521

let stringOfCurve = function
| P256 -> "P-256"
| P384 -> "P-384"
| P521 -> "P-251"

type generateKeyParam = curve
type generateKeyResult = t CryptoKey.pair
type signingParam = (module AlgorithmClass.HashAlgorithm)

type generateKeyParamJs = { namedCurve: string } [@@bs.deriving abstract]
let generateKeyParamToJs (param:generateKeyParam) = generateKeyParamJs ~namedCurve:(stringOfCurve param)

type signingParamJs = { hash: string } [@@bs.deriving abstract]
let signingParamToJs (param:signingParam) =
	let module H = (val param) in
	signingParamJs ~hash:H.id
