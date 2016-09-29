module Utils exposing (..)

import String
import Regex


spaceUppers : String -> String
spaceUppers s =
    Regex.replace Regex.All
        (Regex.regex "[a-z][A-Z]")
        (\{ match } -> String.left 1 match ++ " " ++ String.dropLeft 1 match)
        s


capitalize : String -> String
capitalize word =
    (String.left 1 word |> String.toUpper) ++ (String.dropLeft 1 word)


upperFirst : String -> String
upperFirst s =
    List.map capitalize (String.words s) |> String.join " "
