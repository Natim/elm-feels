module Models exposing (..)

import Routing exposing (Route(..))
import Feel.Models exposing (Feel)
import Messages exposing (Msg(..))
import Feel.Commands exposing (fetchAll)


type alias Model =
    { feelModel : Feel.Models.Model
    , route : Routing.Route
    }


defaultState : Routing.Route -> Model
defaultState route =
    { feelModel = Feel.Models.init
    , route = route
    }


initialModel : Routing.Route -> ( Model, Cmd Msg )
initialModel route =
    ( defaultState route, Cmd.map FeelMessage fetchAll )
