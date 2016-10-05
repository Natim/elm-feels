module FeelForm.Validate exposing (..)

import Date exposing (Date)
import Feel.Mood exposing (Mood(..))
import String


validateMood : Maybe Mood -> Result String Mood
validateMood unvalidatedMood =
    case unvalidatedMood of
        Nothing ->
            Err "Please select a mood!"

        Just mood ->
            Ok mood


validateDescription : Maybe String -> Result String String
validateDescription unvalidatedDescription =
    let
        description =
            Maybe.withDefault "" unvalidatedDescription
    in
        if String.length description == 0 then
            Err "Please enter a description!"
        else
            Ok description


validateTimestamp : Maybe Date -> Result String Date
validateTimestamp unvalidatedTimestamp =
    case unvalidatedTimestamp of
        Nothing ->
            Err "Please select a mood!"

        Just date ->
            Ok date


validate : Maybe Mood -> Maybe String -> Maybe Date -> Result String ( Mood, String, Date )
validate mood desc ts =
    Result.map3 (\m d t -> ( m, d, t ))
        (validateMood mood)
        (validateDescription desc)
        (validateTimestamp ts)
