module Utils exposing (..)

import String


capitalize : String -> String
capitalize word =
    (String.left 1 word |> String.toUpper) ++ (String.dropLeft 1 word)


upperFirst : String -> String
upperFirst s =
    List.map capitalize (String.words s) |> String.join " "
