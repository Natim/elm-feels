module Feel.Commands exposing (..)

import Feel.Models exposing (constructFeel)
import Feel.Mood exposing (Mood(..))
import Date exposing (Date)
import Date.Extra
import Feel.Messages exposing (..)
import Feel.Decoder
import HttpBuilder
import Json.Encode as Encode
import Feel.Mood
import Task


fetchAll =
    HttpBuilder.get feelsUrl
        |> HttpBuilder.withHeader "Content-Type" "application/json"
        |> HttpBuilder.send (HttpBuilder.jsonReader Feel.Decoder.collectionDecoder) HttpBuilder.stringReader
        |> Task.perform FetchAllFail (\{ data } -> FetchAllDone data)


feelsUrl : String
feelsUrl =
    "http://localhost:4000/feels"


feelEncoder mood description timestamp =
    Encode.object
        [ ( "timestamp", Encode.string <| Date.Extra.toUtcIsoString timestamp )
        , ( "mood", Encode.string <| Feel.Mood.toLabel mood )
        , ( "description", Encode.string description )
        ]


saveFeel : Mood -> String -> Date -> Cmd Msg
saveFeel mood description timestamp =
    HttpBuilder.post feelsUrl
        |> HttpBuilder.withJsonBody (feelEncoder mood description timestamp)
        |> HttpBuilder.withHeader "Content-Type" "application/json"
        |> HttpBuilder.send (HttpBuilder.jsonReader Feel.Decoder.idDecoder) HttpBuilder.stringReader
        |> Task.perform SaveFeelFail (\{ data } -> SaveFeelDone (constructFeel data description mood timestamp))
