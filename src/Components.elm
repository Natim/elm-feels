module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type alias Icon =
    String


type alias Classes =
    String


icon : Icon -> Html msg
icon icon' =
    i [ class "icon is-small" ] [ i [ class <| "fa " ++ icon' ] [] ]


actionLink : Classes -> msg -> List (Html.Html msg) -> Html msg
actionLink classes action content =
    a [ class classes, onClick action ] content


buttonLink : msg -> Icon -> String -> Html msg
buttonLink action icon' label =
    actionLink "button is-primary is-large"
        action
        [ icon icon'
        , span []
            [ text label ]
        ]
