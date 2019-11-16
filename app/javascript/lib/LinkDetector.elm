module LinkDetector exposing (LogPart (..), splitLine)

type LogPart = Text String | URL String

type alias LogLine = (List LogPart)

splitLine : String -> LogLine
splitLine str =
  if str == "" then
    []
  else
    let
        (part, rest) = getPart str
    in
        part::splitLine rest



getPart : String -> (LogPart, String)
getPart line =
  if String.startsWith "http" line then
    getURL line
  else
    getText line

getURL : String -> (LogPart, String)
getURL line =
    String.split " " line
      |> List.head
      |> Maybe.map (\url -> (URL url, String.dropLeft (String.length url) line))
      |> Maybe.withDefault (Text "", line)


getText : String -> (LogPart, String)
getText line =
  let
      urlStartsAt = String.indexes "http" line
  in
      case urlStartsAt of
        [] -> (Text line, "")
        urlIndex::_ -> (Text <| String.slice 0 urlIndex line, String.dropLeft urlIndex line)

{-
lineParser : Parser (List LogPart)
lineParser =
  loop [] lineParserLoop

lineParserLoop : List LogPart -> Parser (Step (List LogPart) (List LogPart))
lineParserLoop parts =
  oneOf
    [ succeed (\part -> Loop (part :: parts)) |= partParser
    , succeed () |> map (\_ -> Done (List.reverse parts))
    ]


partParser : Parser LogPart
partParser = oneOf [ urlParser, textParser ]

urlParser : Parser LogPart
urlParser =
  succeed (\string -> URL ("http" ++ string))
    |. keyword "http"
    |= getChompedString (chompWhile (\char -> char /= ' '))

textParser : Parser LogPart
textParser =
  succeed Text
    |= getChompedString (chompUntilEndOr "http") |> andThen (\str -> if str == "" then problem "empty" else succeed str)
-}
