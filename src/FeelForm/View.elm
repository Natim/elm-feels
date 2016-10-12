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
import Feel.Models exposing (FeelId)
import Utils exposing (maybeRender)


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
            , maybeRender errorMessage model.error
            , p [ class "control is-grouped" ]
                [ p [ class "control" ] [ saveButton ]
                , p [ class "control" ]
                    [ maybeRender deleteButton model.id
                    ]
                , p [ class "control" ] [ cancelButton ]
                ]
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
            [ maybeRender Feel.Mood.view model.mood
            ]
        , br [] []
        ]


feelDescriber : Model -> Html Msg
feelDescriber { description, descriptionPlaceholder } =
    div []
        [ cLabel "What's going on?"
        , p [ class "control" ]
            [ textarea
                [ class "textarea"
                , placeholder descriptionPlaceholder
                , onInput SetDescription
                , value (Maybe.withDefault "" description)
                ]
                []
            ]
        ]


timeOfFeel : Model -> Html Msg
timeOfFeel { timestamp } =
    div []
        [ cLabel "Time of Feel"
        , div []
        [ text
            <| Date.Extra.toFormattedString "hh:mm a - dd MMMM y"
            <| Maybe.withDefault (Date.fromTime 0) timestamp
        ]
        , input
            [ id "test123"
            , type' "text"
            ] []
            --[ text "asd" ]
            --<| Date.Extra.toFormattedString "hh:mm a - dd MMMM y"
            --<| Maybe.withDefault (Date.fromTime 0) timestamp
        , buttonLink ChooseTime "fa-check" "Choose time" ""
        ]


saveButton : Html Msg
saveButton =
    buttonLink Save "fa-check" "Save" ""


cancelButton : Html Msg
cancelButton =
    a [ class "button", onClick Cancel ] [ span [] [ text "Cancel" ] ]


deleteButton : FeelId -> Html Msg
deleteButton id =
    a [ class "button is-danger", onClick (Delete id) ]
        [ icon "fa-times"
        , span []
            [ text "Delete" ]
        ]


errorMessage : String -> Html Msg
errorMessage error =
    div [ class "notification is-danger" ]
        [ icon "fa-exclamation-triangle"
        , span []
            [ text error ]
        ]
