module Views exposing (..)

import Models exposing (Model)
import Routing exposing (Route(..))
import Messages exposing (Msg(..))
import Html exposing (..)
import Html.App
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Feel.List


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        FeelsOverviewRoute ->
            Html.App.map FeelMessage (Feel.List.view model.feels)

        NotFoundRoute ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    div [] [ text "Not found" ]
