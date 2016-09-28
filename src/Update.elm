module Update exposing (..)

import Routing exposing (Route)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Feel.Update


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "msg" msg) of
        FeelMessage subMsg ->
            let
                ( updatedFeels, cmd ) =
                    Feel.Update.update subMsg model.feels
            in
                ( { model | feels = updatedFeels }, Cmd.map FeelMessage cmd )
