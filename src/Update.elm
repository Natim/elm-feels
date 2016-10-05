module Update exposing (..)

import Routing exposing (Route)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Feel.Update
import FeelForm.Commands
import Feel.Messages exposing (Msg(..))
import FeelForm.Messages exposing (Msg(..))
import Feel.Commands


{-|
  TODO: these are only run when the route is entered from another route.
  We need to also perform these actions when entering this route as the first one
  Maybe something like `onRouteEnter`
-}
urlUpdate : Result String Route -> Model -> ( Model, Cmd Messages.Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result

        command =
            case (Debug.log "route" currentRoute) of
                Routing.CreateFeelRoute ->
                    Cmd.map FeelMessage
                        <| Cmd.map FeelFormMessage
                        <| Cmd.batch
                            [ FeelForm.Commands.generateDescriptionPlaceholder
                            , FeelForm.Commands.generateTimestamp
                            ]

                Routing.EditFeelRoute id ->
                    Cmd.map FeelMessage
                        <| Feel.Commands.fetchById id (\x -> FeelFormMessage (InitFrom x))

                _ ->
                    Cmd.none
    in
        ( { model | route = currentRoute }, command )


update : Messages.Msg -> Model -> ( Model, Cmd Messages.Msg )
update msg model =
    case (Debug.log "msg" msg) of
        FeelMessage subMsg ->
            let
                ( updatedFeelModel, cmd ) =
                    Feel.Update.update subMsg model.feelModel
            in
                ( { model | feelModel = updatedFeelModel }, Cmd.map FeelMessage cmd )
