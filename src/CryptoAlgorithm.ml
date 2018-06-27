module Class = CryptoAlgorithmClass
open Class
module AesCtr = (CryptoAlgorithmAesCtr : EncryptionAlgorithm
	with type generateKeyParam = CryptoAlgorithmAesCtr.generateKeyParam
	and type encryptionParam = CryptoAlgorithmAesCtr.encryptionParam)
module RsaPss = (CryptoAlgorithmRsaPss : SigningAlgorithm
	with type generateKeyParam = CryptoAlgorithmRsaPss.generateKeyParam
	and type signingParam = CryptoAlgorithmRsaPss.signingParam)
module RsaOaep = (CryptoAlgorithmRsaOaep : EncryptionAlgorithm
	with type generateKeyParam = CryptoAlgorithmRsaOaep.generateKeyParam
	and type encryptionParam = CryptoAlgorithmRsaOaep.encryptionParam)
(*module Pkcs2 = (CryptoAlorithmPkcs2 : KeyDerivationAlgorithm)*)
module Sha1 = (CryptoAlgorithmSha1 : HashAlgorithm)
module Sha256 = (CryptoAlgorithmSha256 : HashAlgorithm)
module Sha384 = (CryptoAlgorithmSha384 : HashAlgorithm)
module Sha512 = (CryptoAlgorithmSha512 : HashAlgorithm)
