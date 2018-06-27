module type Algorithm = sig
	val id : string
	type t
end

module type KeyAlgorithm = sig
	include Algorithm
	type generateKeyParam
	type generateKeyResult

	type generateKeyParamJs
	val generateKeyParamToJs : generateKeyParam -> generateKeyParamJs
end

module type EncryptionAlgorithm = sig
	include KeyAlgorithm
	type encryptionParam

	type encryptionParamJs
	val encryptionParamToJs : encryptionParam -> encryptionParamJs
end

module type SigningAlgorithm = sig
	include KeyAlgorithm
	type signingParam

	type signingParamJs
	val signingParamToJs : signingParam -> signingParamJs
end

module type HashAlgorithm = sig
	include Algorithm

	val digestSize : int
end

module type BitDerivationAlgorithm = sig
	include Algorithm
	type bitDerivationParam

	type bitDerivationParamJs
	val bitDerivationParamToJs : bitDerivationParam -> bitDerivationParamJs
end

module type KeyDerivationAlgorithm = sig
	include Algorithm
	type keyDerivationParam

	type keyDerivationParamJs
	val keyDerivationParamToJs : keyDerivationParam -> keyDerivationParamJs
end
