module Main exposing (..)

import Routes exposing (Route(..))
import Routing
import Navigation
import Models exposing (Model)
import Update
import Views
import Messages exposing (Msg(..))


init : Result String Route -> ( Model, Cmd Msg )
init result =
    Models.initialModel <| Routing.routeFromResult result


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = Views.view
        , update = Update.update
        , urlUpdate = Update.urlUpdate
        , subscriptions = subscriptions
        }
