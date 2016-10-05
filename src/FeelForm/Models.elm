module FeelForm.Models exposing (..)

import Feel.Mood exposing (Mood)
import Date exposing (Date)


init : Model
init =
    { description = Nothing
    , mood = Nothing
    , timestamp = Nothing
    , descriptionPlaceholder = "Write a bit about how you're feeling"
    , error = Nothing
    }


{-|
TODO: need to keep track of whether this is a new Feel or if we're updating a pre-existing one
-}
type alias Model =
    { description : Maybe String
    , mood : Maybe Mood
    , timestamp : Maybe Date
    , descriptionPlaceholder : String
    , error : Maybe String
    }
