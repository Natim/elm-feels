module Mood exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Utils exposing (upperFirst)


type alias Emoji =
    String


type Mood
    = Terrible
    | VeryBad
    | Bad
    | Okay
    | Good
    | VeryGood
    | Fantastic


toEmoji : Mood -> Emoji
toEmoji mood =
    case mood of
        Terrible ->
            "😭"

        VeryBad ->
            "😢"

        Bad ->
            "🙁"

        Okay ->
            "🙂"

        Good ->
            "😀"

        VeryGood ->
            "😄"

        Fantastic ->
            "😁"


toLabel : Mood -> String
toLabel mood =
    case mood of
        Terrible ->
            "terrible"

        VeryBad ->
            "very bad"

        Bad ->
            "bad"

        Okay ->
            "okay"

        Good ->
            "good"

        VeryGood ->
            "very good"

        Fantastic ->
            "fantastic"


fromLabel : String -> Maybe Mood
fromLabel label =
    case label of
        "terrible" ->
            Just Terrible

        "very bad" ->
            Just VeryBad

        "bad" ->
            Just Bad

        "okay" ->
            Just Okay

        "good" ->
            Just Good

        "very good" ->
            Just VeryGood

        "fantastic" ->
            Just Fantastic

        _ ->
            Nothing


view mood =
    div [ class "has-text-centered" ]
        [ p [ class "title is-2", style [ ( "marginBottom", ".5em" ) ] ]
            [ text (toEmoji mood) ]
        , p [ class "subtitle is-5" ]
            [ text (toLabel mood |> upperFirst) ]
        ]
