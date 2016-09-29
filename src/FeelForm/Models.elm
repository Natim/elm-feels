module FeelForm.Models exposing (..)

import Feel.Mood exposing (Mood)


defaultState : Model
defaultState =
    { description = Nothing
    , mood = Nothing
    , descriptionPlaceholder = "Write a bit about how you're feeling"
    }


{-|
TODO: currenly descriptionPlaceholder is only updated when the route is changed to CreateFeelRoute
-}
type alias Model =
    { description : Maybe String
    , mood : Maybe Mood
    , descriptionPlaceholder : String
    }
