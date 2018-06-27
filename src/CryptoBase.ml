type crypto
type subtle

external crypto : crypto = "window.crypto" [@@bs.val]
external getSubtle : crypto -> subtle = "subtle" [@@bs.get]
let subtle = crypto |> getSubtle
