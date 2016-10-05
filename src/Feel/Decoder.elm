module Feel.Decoder exposing (..)

import Feel.Models exposing (Feel, FeelId)
import Feel.Mood exposing (Mood(..))
import Json.Decode as Decode exposing ((:=), andThen)
import Date


idDecoder : Decode.Decoder FeelId
idDecoder =
    ("id" := Decode.string)


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
    case Date.fromString timestamp of
        Err err ->
            Decode.fail err

        Ok ts ->
            Decode.succeed ts


moodDecoder : Decode.Decoder Mood
moodDecoder =
    ("mood" := Decode.string) `andThen` decodeMood


decodeMood : String -> Decode.Decoder Mood
decodeMood mood =
    case Feel.Mood.fromLabel mood of
        Just m ->
            Decode.succeed m

        Nothing ->
            Decode.fail (mood ++ " is not a recognized mood")
