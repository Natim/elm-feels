module Feel.Update exposing (..)

import Navigation
import Feel.Messages exposing (..)
import Feel.Models exposing (..)
import Feel.Commands
import FeelForm.Update
import FeelForm.Messages
import Dict exposing (Dict)


{-| TODO: clean up API, don't want this here
-}
setFeel : Feel -> Dict FeelId Feel -> Dict FeelId Feel
setFeel feel =
    Dict.insert feel.id feel


removeFeelById : FeelId -> Dict FeelId Feel -> Dict FeelId Feel
removeFeelById id =
    Dict.remove id


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
            ( { model
                | feels = Dict.fromList <| List.map (\feel -> ( feel.id, feel )) fetchedFeels
              }
            , Cmd.none
            )

        FetchFeelDone feel ->
            ( model, Cmd.none )

        FetchFeelFail error ->
            ( model, Cmd.none )

        EditFeel feel ->
            let
                ( updatedFeelForm, _, _ ) =
                    FeelForm.Update.update (FeelForm.Messages.InitFrom feel) model.feelForm
            in
                ( { model | feelForm = updatedFeelForm }, Navigation.newUrl <| "#feel/" ++ feel.id )

        ShowFeelsOverview ->
            ( model, Navigation.newUrl "#feels" )

        ShowAddFeel ->
            let
                ( updatedFeelForm, cmd, _ ) =
                    FeelForm.Update.update FeelForm.Messages.Reset model.feelForm
            in
                ( { model | feelForm = updatedFeelForm }
                , Cmd.batch
                    [ Navigation.newUrl "#feel/new"
                    , Cmd.map FeelFormMessage cmd
                    ]
                )

        CreateFeel mood description timestamp ->
            ( model, Feel.Commands.createFeel mood description timestamp )

        CreateFeelFail error ->
            ( model, Cmd.none )

        CreateFeelDone feel ->
            ( { model | feels = setFeel feel model.feels }, Navigation.newUrl "#feels" )

        UpdateFeel feel ->
            ( model, Feel.Commands.updateFeel feel )

        UpdateFeelFail error ->
            ( model, Cmd.none )

        UpdateFeelDone feel ->
            ( { model | feels = setFeel feel model.feels }, Navigation.newUrl "#feels" )

        DeleteFeel id ->
            ( model, Feel.Commands.deleteFeel id )

        DeleteFeelDone id ->
            ( { model | feels = removeFeelById id model.feels }, Navigation.newUrl "#feels" )

        DeleteFeelFail error ->
            ( model, Cmd.none )
