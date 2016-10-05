module FeelForm.Update exposing (..)

import FeelForm.Messages exposing (..)
import FeelForm.Models exposing (..)
import FeelForm.Commands exposing (..)
import FeelForm.Validate exposing (validate)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        SetDescription newDescription ->
            ( { model | description = Just newDescription }, Cmd.none )

        SetMood newMood ->
            ( { model | mood = Just newMood }, Cmd.none )

        SetDescriptionPlaceholder placeholder ->
            ( { model | descriptionPlaceholder = placeholder }, Cmd.none )

        GenerateDescriptionPlaceholder ->
            ( model, generateDescriptionPlaceholder )

        SetTimestamp ts ->
            ( { model | timestamp = Just ts }, Cmd.none )

        SetTimestampFail err ->
            ( { model | timestamp = Nothing }, Cmd.none )

        Validate ->
            case (validate model.mood model.description model.timestamp) of
                Ok () ->
                    ( { model | error = Nothing }, Cmd.none )

                Err err ->
                    ( { model | error = Just err }, Cmd.none )

        Save ->
            case (validate model.mood model.description model.timestamp) of
                Ok () ->
                    ( { model | error = Nothing }, Cmd.none )

                Err err ->
                    ( { model | error = Just err }, Cmd.none )
