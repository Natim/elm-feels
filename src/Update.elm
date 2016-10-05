module Update exposing (..)

import Models exposing (Model)
import Messages exposing (Msg(..))
import Feel.Update
import Routes
import Routing


urlUpdate : Result String Routes.Route -> Model -> ( Model, Cmd Messages.Msg )
urlUpdate result model =
    let
        currentRoute =
            (Debug.log "route" <| Routing.routeFromResult result)
    in
        ( { model | route = currentRoute }, Routes.onRouteEnter currentRoute )


update : Messages.Msg -> Model -> ( Model, Cmd Messages.Msg )
update msg model =
    case (Debug.log "msg" msg) of
        FeelMessage subMsg ->
            let
                ( updatedFeelModel, cmd ) =
                    Feel.Update.update subMsg model.feelModel
            in
                ( { model | feelModel = updatedFeelModel }, Cmd.map FeelMessage cmd )
