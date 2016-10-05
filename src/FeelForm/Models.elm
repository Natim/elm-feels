module FeelForm.Models exposing (..)

import Feel.Mood exposing (Mood)
import Date exposing (Date)


init : Model
init =
    { description = Nothing
    , id = Nothing
    , mood = Nothing
    , timestamp = Nothing
    , descriptionPlaceholder = "Write a bit about how you're feeling"
    , error = Nothing
    }


type alias Model =
    { description : Maybe String
    , mood : Maybe Mood
    , timestamp : Maybe Date
    , descriptionPlaceholder : String
    , error : Maybe String
    , id : Maybe String
    }
