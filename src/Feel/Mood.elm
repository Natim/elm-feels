module Feel.Mood exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Utils exposing (upperFirst, spaceUppers)
import String
import Dict


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


moods : List Mood
moods =
    [ Terrible, VeryBad, Bad, Okay, Good, VeryGood, Fantastic ]


toLabel : Mood -> String
toLabel mood =
    toString mood
        |> spaceUppers
        |> String.toLower


moodLabelTuples : List ( String, Mood )
moodLabelTuples =
    List.map (\mood -> ( toLabel mood, mood )) moods


moodLabelDict : Dict.Dict String Mood
moodLabelDict =
    Dict.fromList moodLabelTuples


fromLabel : String -> Maybe Mood
fromLabel label =
    Dict.get label moodLabelDict


view : Mood -> Html a
view mood =
    div [ class "has-text-centered" ]
        [ p [ class "title is-2", style [ ( "marginBottom", ".5em" ) ] ]
            [ text (toEmoji mood) ]
        , p [ class "subtitle is-5" ]
            [ text (toLabel mood |> upperFirst) ]
        ]
