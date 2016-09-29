module FeelForm.View exposing (..)

import FeelForm.Messages exposing (..)
import Html exposing (..)
import Html.Events exposing (onInput)
import Html.Attributes exposing (..)
import FeelForm.Models exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ h1 [ class "title" ]
            [ text "Log a Feel" ]
        , h2 [ class "subtitle" ]
            [ text "How are you doing, pal?" ]
        , hr [] []
        , div []
            [ moodPicker model
            , feelDescriber model
            , timeOfFeel model
            , br [] []
            , saveButton model
            , cancelButton model
            ]
        ]


moodPicker : Model -> Html Msg
moodPicker model =
    div [] [ text "Mood Picker" ]


feelDescriber : Model -> Html Msg
feelDescriber model =
    div []
        [ label [ class "label" ] [ text "What's going on?" ]
        , p [ class "control" ]
            [ textarea
                [ class "textarea"
                , placeholder model.descriptionPlaceholder
                , onInput SetDescription
                ]
                []
            ]
        ]


timeOfFeel : Model -> Html Msg
timeOfFeel model =
    div [] [ text "Time of feel" ]


saveButton : Model -> Html Msg
saveButton model =
    a [ class "button is-primary" ] [ text "Save" ]


cancelButton : Model -> Html Msg
cancelButton model =
    a [ class "button is-link" ] [ text "Cancel" ]
