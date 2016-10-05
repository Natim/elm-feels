module Update exposing (..)

import Routing exposing (Route)
import Models exposing (Model)
import Messages exposing (Msg(..))
import Feel.Update
import FeelForm.Update
import FeelForm.Commands


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result

        command =
            case (Debug.log "route" currentRoute) of
                Routing.CreateFeelRoute ->
                    Cmd.batch
                        [ Cmd.map FeelFormMessage FeelForm.Commands.generateDescriptionPlaceholder
                        , Cmd.map FeelFormMessage FeelForm.Commands.generateTimestamp
                        ]

                _ ->
                    Cmd.none
    in
        ( { model | route = currentRoute }, command )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "msg" msg) of
        FeelMessage subMsg ->
            let
                ( updatedFeelModel, cmd ) =
                    Feel.Update.update subMsg model.feelModel
            in
                ( { model | feelModel = updatedFeelModel }, Cmd.map FeelMessage cmd )

        FeelFormMessage subMsg ->
            let
                ( updatedFeelFormState, cmd ) =
                    FeelForm.Update.update subMsg model.feelFormState
            in
                ( { model | feelFormState = updatedFeelFormState }, Cmd.map FeelFormMessage cmd )
