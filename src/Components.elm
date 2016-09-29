module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type alias Icon =
    String


buttonLink : msg -> Icon -> String -> Html msg
buttonLink action icon label =
    a [ class "button is-primary is-large", onClick action ]
        [ span [ class "icon is-small" ]
            [ i [ class <| "fa " ++ icon ]
                []
            ]
        , span []
            [ text label ]
        ]
