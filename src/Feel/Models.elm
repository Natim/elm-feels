module Feel.Models exposing (..)

import Feel.Mood exposing (Mood(..))
import Date exposing (Date)
import FeelForm.Models
import Dict exposing (Dict)


init : Model
init =
    { feels = Dict.empty
    , feelForm = FeelForm.Models.init
    }


type alias Model =
    { feels : Dict FeelId Feel
    , feelForm : FeelForm.Models.Model
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
