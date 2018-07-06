open Jest
open Js.Typed_array
module TestCrypto = Crypto.Make(SubtleImplementation.Make(SubtleImplementation.NodeSubtle))
;;

module Test(C : sig
	module AesMode : AlgorithmClass.EncryptionAlgorithm
	val encryptionParam : AesMode.encryptionParam
	val generateKeyParam : AesMode.generateKeyParam
end) = struct
	open C
	;;

	describe AesMode.id (fun () ->
		let open ExpectJs in
		let open Key in
		let open PromiseOperators in

		let aesGenerateKey () =
			TestCrypto.generateKey
				(module AesMode)
				generateKeyParam
				~extractable:true
				[|Encrypt; Decrypt|]
		in

		let aesEncrypt cleartext encryptionParam key =
			TestCrypto.encrypt
				(module AesMode)
				encryptionParam
				key
				cleartext
		in

		let aesDecrypt ciphertext encryptionParam key =
			TestCrypto.decrypt
				(module AesMode)
				encryptionParam
				key
				ciphertext
		in

		let aesEncryptDecrypt cleartext =
			aesGenerateKey ()
			>>= (fun key -> (aesEncrypt cleartext encryptionParam key) >|= (fun ciphertext -> (ciphertext, key)))
			>>= (fun (ciphertext, key) -> (aesDecrypt ciphertext encryptionParam key) >|= (fun recleartext -> (ciphertext, recleartext, key)))
			>|= (fun (ciphertext, recleartext, _) -> (ciphertext, recleartext))
		in

		let aesExportKey key =
			TestCrypto.exportKey (module AesMode) (module ExportRaw) key
		in

		testPromise "key generation generates something" (fun () ->
			TestCrypto.generateKey (module AesMode) generateKeyParam [|Encrypt; Decrypt|]
			>|= (fun key -> expect key |> toBeTruthy)
		);

		testPromise "key export looks correct" (fun () ->
			aesGenerateKey ()
			>>= aesExportKey
			>|= ExportRaw.buffer
			>|= (fun exportBuffer ->
				expect (exportBuffer |> ArrayBuffer.byteLength) |> toBe 32
			)
		);

		testPromise "keys are unique" (fun () ->
			Js.Promise.all2 (
				(aesGenerateKey () >>= aesExportKey >|= ExportRaw.buffer >|= Uint32Array.fromBuffer),
				(aesGenerateKey () >>= aesExportKey >|= ExportRaw.buffer >|= Uint32Array.fromBuffer)
			)
			>|= (fun (a, b) ->
				expect a |> not_ |> toEqual b
			)
		);

		testPromise "encryption decryption yields cleartext" (fun () ->
			let cleartext = ArrayBuffer.make 32 in
			aesEncryptDecrypt cleartext
			>|= (fun (_, recleartext) ->
				let cleartextArray = cleartext |> Uint32Array.fromBuffer in
				let recleartextArray = recleartext |> Uint32Array.fromBuffer in
				expect recleartextArray |> toEqual cleartextArray
			)
		);

		testPromise "encryption yields ciphertext" (fun () ->
			let cleartext = ArrayBuffer.make 32 in
			aesEncryptDecrypt cleartext
			>|= (fun (ciphertext, _) ->
				let cleartextArray = cleartext |> Uint32Array.fromBuffer in
				let ciphertextArray = ciphertext |> Uint32Array.fromBuffer in
				expect ciphertextArray |> not_ |> toEqual cleartextArray
			)
		);

		testPromise "decryption with wrong key yields garbage or fails" (fun () ->
			let cleartext = ArrayBuffer.make 32 in
			aesGenerateKey ()
			>>= aesEncrypt cleartext encryptionParam
			>>= (fun ciphertext ->
				aesGenerateKey ()
				>>= aesDecrypt ciphertext encryptionParam
			)
			>|= (fun badCleartext ->
				let cleartextArray = cleartext |> Uint32Array.fromBuffer in
				let badCleartextArray = badCleartext |> Uint32Array.fromBuffer in
				expect badCleartextArray |> not_ |> toEqual cleartextArray
			) |> Js.Promise.catch (fun error ->
				expect error |> toBeTruthy |> Js.Promise.resolve
			)
		)
	)
end

include Test(struct
	module AesMode = AlgorithmAesCtr;;
	let encryptionParam = { AesMode.counter=ArrayBuffer.make 16; length=24 }
	let generateKeyParam = { AesMode.length=256 }
end)

include Test(struct
	module AesMode = AlgorithmAesCbc;;
	let encryptionParam = { AesMode.initVector=ArrayBuffer.make 16 }
	let generateKeyParam = { AesMode.length=256 }
end)

include Test(struct
	module AesMode = AlgorithmAesGcm;;
	let encryptionParam = { AesMode.initVector=ArrayBuffer.make 16; authData=ArrayBuffer.make 16; length=128 }
	let generateKeyParam = { AesMode.length=256 }
end)
