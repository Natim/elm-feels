module Feel.Messages exposing (..)

import HttpBuilder
import Feel.Models exposing (Feel, FeelId)
import Date exposing (Date)
import Feel.Mood exposing (Mood(..))
import FeelForm.Messages


type Msg
    = FeelFormMessage FeelForm.Messages.Msg
    | FetchAllDone (List Feel)
    | FetchAllFail String
    | FetchFeelDone Feel
    | FetchFeelFail String
    | ShowFeelsOverview
    | ShowAddFeel
    | CreateFeel Mood String Date
    | CreateFeelFail (HttpBuilder.Error String)
    | CreateFeelDone Feel
    | EditFeel Feel
    | UpdateFeelDone Feel
    | UpdateFeelFail (HttpBuilder.Error String)
    | UpdateFeel Feel
    | DeleteFeel FeelId
    | DeleteFeelDone FeelId
    | DeleteFeelFail (HttpBuilder.Error String)
