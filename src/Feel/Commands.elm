module Feel.Commands exposing (..)

import Feel.Models exposing (constructFeel, FeelId)
import Feel.Mood exposing (Mood(..))
import Date exposing (Date)
import Feel.Messages exposing (..)
import Feel.Decoder
import HttpBuilder as HB
import Feel.Encoder
import Feel.Mood
import Task


fetchById : FeelId -> (Feel.Models.Feel -> Msg) -> Cmd Msg
fetchById id msg =
    HB.get (feelsUrl ++ "/" ++ id)
        |> HB.send (HB.jsonReader Feel.Decoder.memberDecoder) HB.stringReader
        |> Task.perform FetchFeelFail (\{ data } -> msg data)


fetchAll : Cmd Msg
fetchAll =
    HB.get feelsUrl
        |> HB.send (HB.jsonReader Feel.Decoder.collectionDecoder) HB.stringReader
        |> Task.perform FetchAllFail (\{ data } -> FetchAllDone data)


feelsUrl : String
feelsUrl =
    "http://localhost:4000/feels"


saveFeel : Mood -> String -> Date -> Cmd Msg
saveFeel mood description timestamp =
    HB.post feelsUrl
        |> HB.withJsonBody (Feel.Encoder.feelEncoder mood description timestamp)
        |> HB.withHeader "Content-Type" "application/json"
        |> HB.send (HB.jsonReader Feel.Decoder.idDecoder) HB.stringReader
        |> Task.perform SaveFeelFail (\{ data } -> SaveFeelDone (constructFeel data description mood timestamp))
