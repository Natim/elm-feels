module Feel.Commands exposing (..)

import Json.Decode as Decode exposing ((:=), andThen)
import Feel.Messages exposing (..)
import Feel.Models exposing (Feel)
import Mood exposing (Mood(..))
import Task
import Http
import Date


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/feels"


collectionDecoder : Decode.Decoder (List Feel)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Feel
memberDecoder =
    Decode.object4 Feel
        ("id" := Decode.string)
        ("description" := Decode.string)
        moodDecoder
        timestampDecoder


timestampDecoder : Decode.Decoder Date.Date
timestampDecoder =
    ("timestamp" := Decode.string) `andThen` decodeTimestamp


decodeTimestamp : String -> Decode.Decoder Date.Date
decodeTimestamp timestamp =
    let
        convertedTimestamp =
            Date.fromString timestamp
    in
        case convertedTimestamp of
            Err err ->
                Decode.fail err

            Ok ts ->
                Decode.succeed ts


moodDecoder : Decode.Decoder Mood
moodDecoder =
    ("mood" := Decode.string) `andThen` decodeMood


decodeMood : String -> Decode.Decoder Mood
decodeMood mood =
    let
        convertedMood =
            Mood.fromLabel mood
    in
        case convertedMood of
            Just m ->
                Decode.succeed m

            Nothing ->
                Decode.fail (mood ++ " is not a recognized mood")
