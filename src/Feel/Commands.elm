module Feel.Commands exposing (..)

import Feel.Models exposing (constructFeel, FeelId, Feel)
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



-- fetchAll : Cmd Msg
-- fetchAll =
--     HB.get feelsUrl
--         |> HB.send (HB.jsonReader Feel.Decoder.collectionDecoder) HB.stringReader
--         |> Task.perform FetchAllFail (\{ data } -> FetchAllDone data)


host : String
host =
    "http://localhost:4000"


feelsUrl : String
feelsUrl =
    host ++ "/feels"


feelUrl : FeelId -> String
feelUrl id =
    host ++ "/feels/" ++ id


createFeel : Mood -> String -> Date -> Cmd Msg
createFeel mood description timestamp =
    HB.post feelsUrl
        |> HB.withJsonBody (Feel.Encoder.feelEncoder mood description timestamp)
        |> HB.withHeader "Content-Type" "application/json"
        |> HB.send (HB.jsonReader Feel.Decoder.idDecoder) HB.stringReader
        |> Task.perform CreateFeelFail (\{ data } -> CreateFeelDone (constructFeel data description mood timestamp))


updateFeel : Feel -> Cmd Msg
updateFeel feel =
    HB.put (feelUrl feel.id)
        |> HB.withJsonBody (Feel.Encoder.feelEncoder feel.mood feel.description feel.timestamp)
        |> HB.withHeader "Content-Type" "application/json"
        |> HB.send (HB.jsonReader Feel.Decoder.memberDecoder) HB.stringReader
        |> Task.perform UpdateFeelFail (\{ data } -> UpdateFeelDone data)


deleteFeel : FeelId -> Cmd Msg
deleteFeel id =
    HB.delete (feelUrl id)
        |> HB.send HB.unitReader HB.stringReader
        |> Task.perform DeleteFeelFail (\_ -> DeleteFeelDone id)
