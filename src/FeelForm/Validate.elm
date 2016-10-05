module FeelForm.Validate exposing (..)

import Date exposing (Date)
import Feel.Models exposing (Feel)
import Feel.Mood exposing (Mood(..))
import String


validate : Maybe Mood -> Maybe String -> Maybe Date -> Result String ()
validate mood description timestamp =
    if mood == Nothing then
        Err "Please select a mood!"
    else if String.length (Maybe.withDefault "" description) == 0 then
        Err "Please enter a description!"
    else if timestamp == Nothing then
        Err "Please set a time!"
    else
        Ok ()
