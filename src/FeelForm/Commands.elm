module FeelForm.Commands exposing (..)

import Array
import Random
import Random.Array
import FeelForm.Messages exposing (..)
import Date
import Task


descriptionPlaceholders : Array.Array String
descriptionPlaceholders =
    Array.fromList
        <| [ "Got a promotion at work!"
           , "A really beautiful person walked past me on the street"
           , "I'm on a date!"
           ]


generateDescriptionPlaceholder : Cmd Msg
generateDescriptionPlaceholder =
    Random.generate (\x -> Maybe.withDefault "" x |> SetDescriptionPlaceholder)
        (Random.Array.sample descriptionPlaceholders)


generateTimestamp : Cmd Msg
generateTimestamp =
    Date.now |> Task.perform SetTimestampFail SetTimestamp
