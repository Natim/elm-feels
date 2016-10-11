module Main exposing (..)

import Routes exposing (Route(..))
import Routing
import Navigation
import Models exposing (Model)
import Update
import Views
import Messages exposing (Msg(..))
import Feathers
import Feel.Decoder
import Json.Decode
import Feel.Messages


init : Result String Route -> ( Model, Cmd Msg )
init result =
    Models.initialModel <| Routing.routeFromResult result


handle : Json.Decode.Value -> Msg
handle value =
    let
        decodedValue =
            Json.Decode.decodeValue Feel.Decoder.collectionDecoder value

        msg =
            case decodedValue of
                Ok v ->
                    Feel.Messages.FetchAllDone v

                Err s ->
                    Feel.Messages.FetchAllFailed s
    in
        FeelMessage (msg)


subscriptions : Model -> Sub Msg
subscriptions model =
    Feathers.getFeelsDone handle


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = Views.view
        , update = Update.update
        , urlUpdate = Update.urlUpdate
        , subscriptions = subscriptions
        }
