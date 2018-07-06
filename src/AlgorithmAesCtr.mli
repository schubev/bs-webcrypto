open Js.Typed_array

type t
val id : string

type generateKeyParam = { length: int }
type generateKeyParamJs
type generateKeyResult = t Key.t
val generateKeyParamToJs : generateKeyParam -> generateKeyParamJs

type encryptionParam = { counter: ArrayBuffer.t; length: int }
type encryptionParamJs
val encryptionParamToJs : encryptionParam -> encryptionParamJs
