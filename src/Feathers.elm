port module Feathers exposing (..)

import Json.Decode as Json


port getFeels : () -> Cmd msg


port getFeelsDone : (Json.Value -> msg) -> Sub msg
