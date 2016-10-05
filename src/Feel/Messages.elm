module Feel.Messages exposing (..)

import HttpBuilder
import Feel.Models exposing (Feel, FeelId)
import Date exposing (Date)
import Feel.Mood exposing (Mood(..))
import FeelForm.Messages


type Msg
    = FeelFormMessage FeelForm.Messages.Msg
    | FetchAllDone (List Feel)
    | FetchAllFail (HttpBuilder.Error String)
    | FetchFeelDone Feel
    | FetchFeelFail (HttpBuilder.Error String)
    | ShowFeelsOverview
    | ShowAddFeel
    | SaveFeel Mood String Date
    | SaveFeelFail (HttpBuilder.Error String)
    | SaveFeelDone Feel
    | EditFeel Feel
