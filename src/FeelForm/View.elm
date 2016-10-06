module FeelForm.View exposing (..)

import FeelForm.Messages exposing (..)
import Html exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (..)
import FeelForm.Models exposing (Model)
import Feel.Mood exposing (Mood)
import Date.Extra
import Date
import Components exposing (cLabel, buttonLink, icon)


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
        classes =
            "button is-large is-white"
                ++ if model.mood == Just mood then
                    " is-active"
                   else
                    ""
    in
        div [ class "column is-narrow" ]
            [ a
                [ class classes
                , onClick (SetMood mood)
                , style [ ( "font-size", "2.5em" ) ]
                ]
                [ text <| Feel.Mood.toEmoji mood ]
            ]


moodPicker : Model -> Html Msg
moodPicker model =
    div []
        [ cLabel "How's your current mood?"
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
        [ cLabel "What's going on?"
        , p [ class "control" ]
            [ textarea
                [ class "textarea"
                , placeholder model.descriptionPlaceholder
                , onInput SetDescription
                , value (Maybe.withDefault "" model.description)
                ]
                []
            ]
        ]


timeOfFeel : Model -> Html Msg
timeOfFeel model =
    div []
        [ cLabel "Time of Feel"
        , text
            <| Date.Extra.toFormattedString "hh:mm a - dd MMMM y"
            <| Maybe.withDefault (Date.fromTime 0) model.timestamp
        ]


saveButton : Model -> Html Msg
saveButton model =
    buttonLink Save "fa-check" "Save" ""


errorMessage : Model -> Html Msg
errorMessage model =
    if model.error /= Nothing then
        div [ class "notification is-danger" ]
            [ span [ class "icon" ]
                [ icon "fa-exclamation-triangle"
                ]
            , span []
                [ text <| Maybe.withDefault "" model.error ]
            ]
    else
        div [] []
