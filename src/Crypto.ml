open Js.Typed_array

module Make(I : Implementation.S) = struct
	module Operations = Operations.Make(I)
end

module Subtle = Make(Implementation.Subtle)
