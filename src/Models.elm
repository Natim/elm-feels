module Models exposing (..)

import Routing exposing (Route(..))
import Feel.Models exposing (Feel)
import Messages exposing (Msg(..))
import Feel.Commands exposing (fetchAll)
import FeelForm.Models


type alias Model =
    { feels : List Feel
    , route : Routing.Route
    , feelFormState : FeelForm.Models.Model
    }


defaultState : Routing.Route -> Model
defaultState route =
    { feels = []
    , route = route
    , feelFormState = FeelForm.Models.defaultState
    }


initialModel : Routing.Route -> ( Model, Cmd Msg )
initialModel route =
    ( defaultState route, Cmd.map FeelMessage fetchAll )
