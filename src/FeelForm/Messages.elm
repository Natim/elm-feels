module FeelForm.Messages exposing (..)

import Feel.Mood exposing (Mood)
import Date exposing (Date)
import Feel.Models exposing (Feel, FeelId)


type Msg
    = InitFrom Feel
    | SetDescriptionPlaceholder String
    | SetDescription String
    | SetTimestamp Date
    | SetTimestampFail Date
    | SetMood Mood
    | GenerateDescriptionPlaceholder
    | Validate
    | Save
    | Reset
    | Cancel
    | Delete FeelId
