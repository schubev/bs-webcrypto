open Js.Typed_array
open CryptoBase

external getRandomUint8Values : crypto -> Uint8Array.t -> Uint8Array.t = "getRandomValues" [@@bs.send]
external getRandomUint8ClampedValues : crypto -> Uint8ClampedArray.t -> Uint8ClampedArray.t = "getRandomValues" [@@bs.send]
external getRandomUint16Values : crypto -> Uint16Array.t -> Uint16Array.t = "getRandomValues" [@@bs.send]
external getRandomUint32Values : crypto -> Uint32Array.t -> Uint32Array.t = "getRandomValues" [@@bs.send]
external getRandomInt8Values : crypto -> Int8Array.t -> Int8Array.t = "getRandomValues" [@@bs.send]
external getRandomInt16Values : crypto -> Int16Array.t -> Int16Array.t = "getRandomValues" [@@bs.send]
external getRandomInt32Values : crypto -> Int32Array.t -> Int32Array.t = "getRandomValues" [@@bs.send]
