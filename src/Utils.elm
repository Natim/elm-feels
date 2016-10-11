module Utils exposing (..)

import String
import Regex
import Html
import Maybe
import List


-- TODO: add helper for conditonally adding classes
-- TODO: convert existing view code to use conditionalClasses


condBuildString : String -> List ( a -> Bool, String ) -> a -> String
condBuildString base predicates arg =
    List.foldl
        (\( predicate, class ) curr ->
            curr
                ++ if predicate arg then
                    " " ++ class
                   else
                    ""
        )
        base
        predicates


conditionalClasses =
    condBuildString


maybeRender : (a -> Html.Html b) -> Maybe a -> Html.Html b
maybeRender mapper maybe =
    Maybe.map mapper maybe |> Maybe.withDefault (Html.text "")


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
