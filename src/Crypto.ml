module Make(I : Implementation.S) = struct
	include Operations.Make(I)
end

include Make(SubtleImplementation)
module Algorithm = struct
	module AesCtr = AlgorithmAesCtr
	module AesCbc = AlgorithmAesCbc
	module AesGcm = AlgorithmAesGcm
	module RsaOaep = AlgorithmRsaOaep
	module RsaPss = AlgorithmRsaPss
	module Ecdsa = AlgorithmEcdsa

	module Sha1 = AlgorithmSha1
	module Sha256 = AlgorithmSha256
	module Sha384 = AlgorithmSha384
	module Sha512 = AlgorithmSha512
end
