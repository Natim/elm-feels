module Feel.Update exposing (..)

import Navigation
import Feel.Messages exposing (..)
import Feel.Models exposing (..)
import Feel.Commands
import FeelForm.Update
import FeelForm.Messages
import Dict exposing (Dict)


gotoFeels : Cmd Msg
gotoFeels =
    Navigation.newUrl "#feels"


gotoNewFeel : Cmd Msg
gotoNewFeel =
    Navigation.newUrl "#feel/new"


gotoFeel : FeelId -> Cmd Msg
gotoFeel id =
    Navigation.newUrl <| "#feel/" ++ id


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
                newModel ! [ Cmd.map FeelFormMessage childCmd, cmd ]

        FetchAllFail error ->
            model ! []

        FetchAllDone fetchedFeels ->
            { model
                | feels =
                    Dict.fromList
                        <| List.map (\f -> ( f.id, f )) fetchedFeels
            }
                ! []

        FetchFeelDone feel ->
            model ! []

        FetchFeelFail error ->
            model ! []

        EditFeel feel ->
            let
                ( updatedFeelForm, _, _ ) =
                    FeelForm.Update.update (FeelForm.Messages.InitFrom feel) model.feelForm
            in
                { model | feelForm = updatedFeelForm }
                    ! [ gotoFeel feel.id ]

        ShowFeelsOverview ->
            model ! [ gotoFeels ]

        ShowAddFeel ->
            let
                ( updatedFeelForm, cmd, _ ) =
                    FeelForm.Update.update FeelForm.Messages.Reset model.feelForm
            in
                { model | feelForm = updatedFeelForm }
                    ! [ gotoNewFeel
                      , Cmd.map FeelFormMessage cmd
                      ]

        CreateFeel mood description timestamp ->
            model ! [ Feel.Commands.createFeel mood description timestamp ]

        CreateFeelFail error ->
            model ! []

        CreateFeelDone feel ->
            { model | feels = setFeel feel model.feels } ! [ gotoFeels ]

        UpdateFeel feel ->
            model ! [ Feel.Commands.updateFeel feel ]

        UpdateFeelFail error ->
            model ! []

        UpdateFeelDone feel ->
            { model | feels = setFeel feel model.feels } ! [ gotoFeels ]

        DeleteFeel id ->
            model ! [ Feel.Commands.deleteFeel id ]

        DeleteFeelDone id ->
            { model | feels = removeFeelById id model.feels } ! [ gotoFeels ]

        DeleteFeelFail error ->
            model ! []
