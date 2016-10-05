module Models exposing (..)

import Feel.Models exposing (Feel)
import Messages exposing (Msg(..))
import Feel.Commands exposing (fetchAll)
import Routes exposing (Route)


type alias Model =
    { feelModel : Feel.Models.Model
    , route : Route
    }


defaultState : Route -> Model
defaultState route =
    { feelModel = Feel.Models.init
    , route = route
    }


initialModel : Route -> ( Model, Cmd Msg )
initialModel route =
    ( defaultState route, Routes.onRouteEnter route )
