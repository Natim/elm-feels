module FeelForm.Commands exposing (..)

import Array
import Random
import Random.Array
import FeelForm.Messages exposing (..)
import Date
import Task


{-|
  Represents a list of options with at least one option
-}
type alias Options a =
    { first : a
    , rest : List a
    }


allOptions : Options a -> List a
allOptions { first, rest } =
    first :: rest


descriptionOptions : Options String
descriptionOptions =
    { first = "Write a bit about how you're feeling"
    , rest =
        [ "Got a promotion at work!"
        , "A really beautiful person walked past me on the street"
        , "I'm on a date!"
        , "Just had a great work out!"
        , "I had the strangest dream last night. :("
        ]
    }


descriptionPlaceholders : Array.Array String
descriptionPlaceholders =
    descriptionOptions |> allOptions |> Array.fromList


generateDescriptionPlaceholder : Cmd Msg
generateDescriptionPlaceholder =
    Random.generate
        (\x ->
            Maybe.withDefault descriptionOptions.first x
                |> SetDescriptionPlaceholder
        )
        (Random.Array.sample descriptionPlaceholders)


generateTimestamp : Cmd Msg
generateTimestamp =
    Date.now |> Task.perform SetTimestampFail SetTimestamp
