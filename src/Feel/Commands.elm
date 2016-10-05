module Feel.Commands exposing (..)

import Feel.Models exposing (constructFeel)
import Feel.Mood exposing (Mood(..))
import Date exposing (Date)
import Feel.Messages exposing (..)
import Feel.Decoder
import HttpBuilder
import Feel.Encoder
import Feel.Mood
import Task


fetchAll : Cmd Msg
fetchAll =
    HttpBuilder.get feelsUrl
        |> HttpBuilder.withHeader "Content-Type" "application/json"
        |> HttpBuilder.send (HttpBuilder.jsonReader Feel.Decoder.collectionDecoder) HttpBuilder.stringReader
        |> Task.perform FetchAllFail (\{ data } -> FetchAllDone data)


feelsUrl : String
feelsUrl =
    "http://localhost:4000/feels"


saveFeel : Mood -> String -> Date -> Cmd Msg
saveFeel mood description timestamp =
    HttpBuilder.post feelsUrl
        |> HttpBuilder.withJsonBody (Feel.Encoder.feelEncoder mood description timestamp)
        |> HttpBuilder.withHeader "Content-Type" "application/json"
        |> HttpBuilder.send (HttpBuilder.jsonReader Feel.Decoder.idDecoder) HttpBuilder.stringReader
        |> Task.perform SaveFeelFail (\{ data } -> SaveFeelDone (constructFeel data description mood timestamp))
