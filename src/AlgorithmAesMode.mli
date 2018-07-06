module type Mode = sig
	type t
	val id : string

	type encryptionParam
	type encryptionParamJs
	val encryptionParamToJs : encryptionParam -> encryptionParamJs
end

module Make(M : Mode) : AlgorithmClass.EncryptionAlgorithm
