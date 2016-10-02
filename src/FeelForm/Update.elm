module FeelForm.Update exposing (..)

import FeelForm.Messages exposing (..)
import FeelForm.Models exposing (..)
import FeelForm.Commands exposing (..)


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
