open Js.Typed_array

module Make(I : Implementation.S) = struct
	module Operations = Operations.Make(I)
end

module Subtle = struct
	include Make(Implementation.Subtle)
	module Algorithm = struct
		module AesCtr = AlgorithmAesCtr
	end
end
