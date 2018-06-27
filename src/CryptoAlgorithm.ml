module Class = AlgorithmClass
open Class
module AesCtr = (AlgorithmAesCtr : EncryptionAlgorithm
	with type generateKeyParam = AlgorithmAesCtr.generateKeyParam
	and type encryptionParam = AlgorithmAesCtr.encryptionParam)
module RsaPss = (AlgorithmRsaPss : SigningAlgorithm
	with type generateKeyParam = AlgorithmRsaPss.generateKeyParam
	and type signingParam = AlgorithmRsaPss.signingParam)
module RsaOaep = (AlgorithmRsaOaep : EncryptionAlgorithm
	with type generateKeyParam = AlgorithmRsaOaep.generateKeyParam
	and type encryptionParam = AlgorithmRsaOaep.encryptionParam)
(*module Pkcs2 = (CryptoAlorithmPkcs2 : KeyDerivationAlgorithm)*)
module Sha1 = (AlgorithmSha1 : HashAlgorithm)
module Sha256 = (AlgorithmSha256 : HashAlgorithm)
module Sha384 = (AlgorithmSha384 : HashAlgorithm)
module Sha512 = (AlgorithmSha512 : HashAlgorithm)
