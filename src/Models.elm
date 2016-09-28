module Models exposing (..)

import Routing exposing (Route(..))
import Feel.Models exposing (Feel)
import Messages exposing (Msg(..))
import Feel.Commands exposing (fetchAll)


type alias Model =
    { feels : List Feel
    , route : Routing.Route
    }


initialModel : Routing.Route -> ( Model, Cmd Msg )
initialModel route =
    case route of
        FeelsOverviewRoute ->
            ( { feels = []
              , route = route
              }
            , Cmd.map FeelMessage fetchAll
            )

        NotFoundRoute ->
            ( { feels = [], route = route }, Cmd.none )
