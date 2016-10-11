module Subscriptions exposing (subscriptions)

import Json.Decode as JD
import Models exposing (Model)
import Messages exposing (Msg(..))
import Feel.Messages
import Feel.Decoder
import Feathers


jsonValueDecoder : JD.Decoder a -> (String -> msg) -> (a -> msg) -> JD.Value -> msg
jsonValueDecoder decoder errorMessage successMessage value =
    case JD.decodeValue decoder value of
        Ok v ->
            successMessage v

        Err s ->
            errorMessage s


subscriptions : Model -> Sub Msg
subscriptions model =
    Feathers.getFeelsDone
        (jsonValueDecoder Feel.Decoder.collectionDecoder
            (\s -> FeelMessage (Feel.Messages.FetchAllFail s))
            (\v -> FeelMessage (Feel.Messages.FetchAllDone v))
        )
