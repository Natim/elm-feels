module FeelForm.Messages exposing (..)

import Feel.Mood exposing (Mood)
import Date exposing (Date)


type Msg
    = SetDescription String
    | SetTimestamp Date
    | SetMood Mood
    | GenerateDescriptionPlaceholder
    | SetDescriptionPlaceholder String
    | SetTimestampFail Date
