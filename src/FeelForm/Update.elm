module FeelForm.Update exposing (..)

import FeelForm.Messages exposing (..)
import FeelForm.Models exposing (..)
import FeelForm.Commands exposing (..)
import FeelForm.Validate exposing (validate)
import Feel.Messages as ParentMessages


update : Msg -> Model -> ( Model, Cmd Msg, Maybe ParentMessages.Msg )
update message model =
    case message of
        SetDescription newDescription ->
            ( { model | description = Just newDescription }, Cmd.none, Nothing )

        SetMood newMood ->
            ( { model | mood = Just newMood }, Cmd.none, Nothing )

        SetDescriptionPlaceholder placeholder ->
            ( { model | descriptionPlaceholder = placeholder }, Cmd.none, Nothing )

        GenerateDescriptionPlaceholder ->
            ( model, generateDescriptionPlaceholder, Nothing )

        SetTimestamp ts ->
            ( { model | timestamp = Just ts }, Cmd.none, Nothing )

        SetTimestampFail err ->
            ( { model | timestamp = Nothing }, Cmd.none, Nothing )

        Validate ->
            case (validate model.mood model.description model.timestamp) of
                Ok _ ->
                    ( { model | error = Nothing }, Cmd.none, Nothing )

                Err err ->
                    ( { model | error = Just err }, Cmd.none, Nothing )

        Save ->
            case (validate model.mood model.description model.timestamp) of
                Ok ( mood, description, timestamp ) ->
                    ( { model | error = Nothing }, Cmd.none, Just (ParentMessages.SaveFeel mood description timestamp) )

                Err err ->
                    ( { model | error = Just err }, Cmd.none, Nothing )
