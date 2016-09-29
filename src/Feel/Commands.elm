module Feel.Commands exposing (..)

import Feel.Messages exposing (..)
import Task
import Http
import Feel.Decoder


fetchAll : Cmd Msg
fetchAll =
    Http.get Feel.Decoder.collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/feels"
