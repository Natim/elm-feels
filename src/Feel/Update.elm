module Feel.Update exposing (..)

import Navigation
import Feel.Messages exposing (..)
import Feel.Models exposing (..)
import Feel.Commands
import FeelForm.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        FeelFormMessage subMsg ->
            let
                ( updatedFeelForm, childCmd, parentMessage ) =
                    FeelForm.Update.update subMsg model.feelForm

                ( newModel, cmd ) =
                    case parentMessage of
                        Nothing ->
                            ( { model | feelForm = updatedFeelForm }, Cmd.none )

                        Just msg ->
                            update msg { model | feelForm = updatedFeelForm }
            in
                ( newModel, Cmd.batch [ Cmd.map FeelFormMessage childCmd, cmd ] )

        FetchAllFail error ->
            ( model, Cmd.none )

        FetchAllDone fetchedFeels ->
            ( { model | feels = fetchedFeels }, Cmd.none )

        ShowFeelsOverview ->
            ( model, Navigation.newUrl "#feels" )

        ShowAddFeel ->
            ( model, Navigation.newUrl "#feel/new" )

        SaveFeel mood description timestamp ->
            ( model, Feel.Commands.saveFeel mood description timestamp )

        SaveFeelFail error ->
            ( model, Cmd.none )

        SaveFeelDone feel ->
            ( { model | feels = feel :: model.feels }, Navigation.newUrl "#feels" )
