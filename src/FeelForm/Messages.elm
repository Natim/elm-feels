module FeelForm.Messages exposing (..)

import Feel.Mood exposing (Mood)
import Date exposing (Date)
import Feel.Models exposing (Feel)


type Msg
    = InitFrom Feel
    | SetDescription String
    | SetTimestamp Date
    | SetMood Mood
    | GenerateDescriptionPlaceholder
    | SetDescriptionPlaceholder String
    | SetTimestampFail Date
    | Validate
    | Save
    | Reset
