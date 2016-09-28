module Feel.Messages exposing (..)

import Http
import Feel.Models exposing (Feel, FeelId)


type Msg
    = FetchAllDone (List Feel)
    | FetchAllFail Http.Error
