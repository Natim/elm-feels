module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type alias Icon =
    String


type alias Classes =
    String


cLabel : String -> Html msg
cLabel s =
    label [ class "label" ] [ text s ]


icon : Icon -> Html msg
icon icon' =
    i [ class "icon" ] [ i [ class <| "fa " ++ icon' ] [] ]


actionLink : Classes -> msg -> List (Html.Html msg) -> Html msg
actionLink classes action content =
    a [ class classes, onClick action ] content


buttonLink : msg -> Icon -> String -> String -> Html msg
buttonLink action icon' label size =
    actionLink ("button is-primary " ++ size)
        action
        [ icon icon'
        , span []
            [ text label ]
        ]
