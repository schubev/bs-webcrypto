open Jest
open Js.Typed_array
module TestCrypto = Crypto.Make(SubtleImplementation.Make(SubtleImplementation.NodeSubtle))
;;

describe "AES-CTR" (fun () ->
	let open ExpectJs in
	let open Crypto.Subtle.Algorithm in
	let open CryptoKey in
	let open PromiseOperators in

	let timeoutIdentity msecs x =
		Js.Promise.make
		(fun ~resolve ~reject:_ ->
			ignore @@ Js.Global.setTimeout (fun () -> resolve x [@bs]) msecs
		)
	in

	let aesGenerateKey () =
		TestCrypto.generateKey
			(module AesCtr)
			{ length=256 }
			~extractable:true
			[|Encrypt; Decrypt|]
	in

	let aesEncrypt cleartext counter key =
		TestCrypto.encrypt
			(module AesCtr)
			{ counter; length=24 }
			key
			cleartext
	in

	let aesDecrypt ciphertext counter key =
		TestCrypto.decrypt
			(module AesCtr)
			{ AesCtr.counter; length=24 }
			key
			ciphertext
	in

	let aesEncryptDecrypt cleartext =
		let counter = ArrayBuffer.make 16 in
		aesGenerateKey ()
		>>= (fun key -> (aesEncrypt cleartext counter key) >|= (fun ciphertext -> (ciphertext, key)))
		>>= (fun (ciphertext, key) -> (aesDecrypt ciphertext counter key) >|= (fun recleartext -> (ciphertext, recleartext, key)))
		>|= (fun (ciphertext, recleartext, _) -> (ciphertext, recleartext))
	in

	let aesExportKey key =
		TestCrypto.exportKey (module AesCtr) (module CryptoKey.Format.Raw) key
	in

	testPromise "key generation generates something" (fun () ->
		TestCrypto.generateKey (module AesCtr) { AesCtr.length=256 } [|Encrypt; Decrypt|]
		>|= (fun key -> expect key |> toBeTruthy)
	);

	testPromise "key export does something" (fun () ->
		aesGenerateKey ()
		>>= aesExportKey
		>|= (fun export ->
			expect export |> toBeTruthy
		)
	);

	testPromise "key export looks correct" (fun () ->
		aesGenerateKey ()
		>>= aesExportKey
		>|= CryptoKey.buffer
		>|= (fun exportBuffer ->
			expect (exportBuffer |> ArrayBuffer.byteLength) |> toBe 32
		)
	);

	testPromise "keys are unique" (fun () ->
		Js.Promise.all2 (
			(aesGenerateKey () >>= aesExportKey >|= CryptoKey.buffer >|= Uint32Array.fromBuffer),
			(aesGenerateKey () >>= aesExportKey >|= CryptoKey.buffer >|= Uint32Array.fromBuffer)
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

	testPromise "decryption with wrong key yields garbage" (fun () ->
		let cleartext = ArrayBuffer.make 32 in
		let counter = ArrayBuffer.make 16 in
		aesGenerateKey ()
		>>= aesEncrypt cleartext counter
		>>= (fun ciphertext ->
			aesGenerateKey ()
			>>= aesDecrypt ciphertext counter
		)
		>|= (fun badCleartext ->
			let cleartextArray = cleartext |> Uint32Array.fromBuffer in
			let badCleartextArray = badCleartext |> Uint32Array.fromBuffer in
			expect badCleartextArray |> not_ |> toEqual cleartextArray
		)
	)
)
