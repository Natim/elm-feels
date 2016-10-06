module FeelForm.Update exposing (..)

import FeelForm.Messages exposing (..)
import FeelForm.Models exposing (..)
import FeelForm.Commands exposing (..)
import FeelForm.Validate exposing (validate)
import Feel.Messages as ParentMessages


update : Msg -> Model -> ( Model, Cmd Msg, Maybe ParentMessages.Msg )
update message model =
    case message of
        InitFrom feel ->
            ( { model
                | description = Just feel.description
                , mood = Just feel.mood
                , timestamp = Just feel.timestamp
                , error = Nothing
                , id = Just feel.id
              }
            , Cmd.none
            , Nothing
            )

        Reset ->
            ( FeelForm.Models.init, Cmd.none, Nothing )

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
                    let
                        cmd =
                            if model.id /= Nothing then
                                ParentMessages.UpdateFeel
                                    { id = Maybe.withDefault "" model.id
                                    , mood = mood
                                    , description = description
                                    , timestamp = timestamp
                                    }
                            else
                                ParentMessages.CreateFeel mood description timestamp
                    in
                        ( { model | error = Nothing }, Cmd.none, Just cmd )

                Err err ->
                    ( { model | error = Just err }, Cmd.none, Nothing )
