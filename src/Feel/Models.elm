module Feel.Models exposing (..)

import Feel.Mood exposing (Mood(..))
import Date exposing (Date)


type alias FeelId =
    String


type alias Feel =
    { id : FeelId
    , description : String
    , mood : Mood
    , timestamp : Date
    }
