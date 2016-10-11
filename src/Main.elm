module Main exposing (..)

import Routes exposing (Route(..))
import Routing
import Navigation
import Models exposing (Model)
import Update
import Views
import Messages exposing (Msg(..))
import Subscriptions


init : Result String Route -> ( Model, Cmd Msg )
init result =
    Models.initialModel <| Routing.routeFromResult result


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = Views.view
        , update = Update.update
        , urlUpdate = Update.urlUpdate
        , subscriptions = Subscriptions.subscriptions
        }
