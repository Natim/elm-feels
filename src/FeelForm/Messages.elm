module FeelForm.Messages exposing (..)

import Feel.Mood exposing (Mood)


type Msg
    = SetDescription String
    | SetMood Mood
    | GenerateDescriptionPlaceholder
    | SetDescriptionPlaceholder String
