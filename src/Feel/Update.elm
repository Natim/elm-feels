module Feel.Update exposing (..)

import Navigation
import Feel.Messages exposing (..)
import Feel.Models exposing (..)


update : Msg -> List Feel -> ( List Feel, Cmd Msg )
update message feels =
    case message of
        FetchAllFail error ->
            ( feels, Cmd.none )

        FetchAllDone fetchedFeels ->
            ( fetchedFeels, Cmd.none )

        ShowFeelsOverview ->
            ( feels, Navigation.newUrl "#feels" )

        ShowAddFeel ->
            ( feels, Navigation.newUrl "#feel/new" )
