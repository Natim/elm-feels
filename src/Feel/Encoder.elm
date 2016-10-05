module Feel.Encoder exposing (..)

import Feel.Mood
import Json.Encode as Encode
import Date.Extra


feelEncoder mood description timestamp =
    Encode.object
        [ ( "timestamp", Encode.string <| Date.Extra.toUtcIsoString timestamp )
        , ( "mood", Encode.string <| Feel.Mood.toLabel mood )
        , ( "description", Encode.string description )
        ]
