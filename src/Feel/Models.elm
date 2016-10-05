module Feel.Models exposing (..)

import Feel.Mood exposing (Mood(..))
import Date exposing (Date)


init : Model
init =
    { feels = []
    }


type alias Model =
    { feels : List Feel
    }


type alias FeelId =
    String


type alias Feel =
    { id : FeelId
    , description : String
    , mood : Mood
    , timestamp : Date
    }


constructFeel : FeelId -> String -> Mood -> Date -> Feel
constructFeel id description mood timestamp =
    { id = id
    , description = description
    , mood = mood
    , timestamp = timestamp
    }
