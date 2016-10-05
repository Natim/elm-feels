module FeelForm.View exposing (..)

import FeelForm.Messages exposing (..)
import Html exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (..)
import FeelForm.Models exposing (Model)
import Feel.Mood exposing (Mood)
import Date.Extra
import Date


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
            , br [] []
            , timeOfFeel model
            , br [] []
            , errorMessage model
            , saveButton model
            ]
        ]


moodButton : Model -> Mood -> Html Msg
moodButton model mood =
    let
        baseClasses =
            "button is-large is-white"

        classes =
            if model.mood == Just mood then
                baseClasses ++ " is-active"
            else
                baseClasses
    in
        div [ class "column is-narrow" ]
            [ a [ class classes, onClick (SetMood mood) ]
                [ text <| Feel.Mood.toEmoji mood ]
            ]


moodPicker : Model -> Html Msg
moodPicker model =
    div []
        [ label [ class "label" ]
            [ text "How's your current mood?" ]
        , div [ class "columns is-multiline is-mobile" ]
            (List.map (moodButton model) Feel.Mood.moods)
        , div []
            <| Maybe.withDefault []
            <| Maybe.map (\x -> [ Feel.Mood.view x ]) model.mood
        , br [] []
        ]


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
    div []
        [ label [ class "label" ] [ text "Time of Feel" ]
        , text
            <| Date.Extra.toFormattedString "hh:mm a - dd MMMM y"
            <| Maybe.withDefault (Date.fromTime 0) model.timestamp
        ]


saveButton : Model -> Html Msg
saveButton model =
    a [ class "button is-primary", onClick Save ]
        [ text "Save" ]


errorMessage : Model -> Html Msg
errorMessage model =
    if model.error /= Nothing then
        div [ class "notification is-danger" ]
            [ span [ class "icon" ]
                [ i [ class "fa fa-exclamation-triangle" ]
                    []
                ]
            , span []
                [ text <| Maybe.withDefault "" model.error ]
            ]
    else
        div [] []
