module Feel.Messages exposing (..)

import HttpBuilder
import Feel.Models exposing (Feel, FeelId)
import Date exposing (Date)
import Feel.Mood exposing (Mood(..))


type Msg
    = FetchAllDone (List Feel)
    | FetchAllFail (HttpBuilder.Error String)
    | ShowFeelsOverview
    | ShowAddFeel
    | SaveFeel Mood String Date
    | SaveFeelFail (HttpBuilder.Error String)
    | SaveFeelDone Feel
