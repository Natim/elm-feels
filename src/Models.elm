module Models exposing (..)

import Routing exposing (Route(..))
import Feel.Models exposing (Feel)
import Messages exposing (Msg(..))
import Feel.Commands exposing (fetchAll)


type alias Model =
    { feels : List Feel
    , route : Routing.Route
    }


defaultState : Routing.Route -> Model
defaultState route =
    { feels = []
    , route = route
    }


initialModel : Routing.Route -> ( Model, Cmd Msg )
initialModel route =
    case route of
        ViewFeelsRoute ->
            ( defaultState route, Cmd.map FeelMessage fetchAll )

        CreateFeelRoute ->
            ( defaultState route, Cmd.none )

        NotFoundRoute ->
            ( defaultState route, Cmd.none )
