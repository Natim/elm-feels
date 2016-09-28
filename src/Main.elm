module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Mood exposing (Mood(..))
import String
import Utils
import Messages exposing (..)
import Feel.List
import Feel.Models exposing (Feel)
import Feel.Commands exposing (fetchAll)
import Feel.Update


type alias Model =
    { feels : List Feel
    }


init : ( Model, Cmd Msg )
init =
    ( { feels = [] }
    , Cmd.map FeelMessage fetchAll
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "msg" msg) of
        FeelMessage subMsg ->
            let
                ( updatedFeels, cmd ) =
                    Feel.Update.update subMsg model.feels
            in
                ( { model | feels = updatedFeels }, Cmd.map FeelMessage cmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    App.map FeelMessage (Feel.List.view model.feels)


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
