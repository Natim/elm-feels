module Routing exposing (..)

import String
import Navigation
import UrlParser exposing ((</>))
import Feel.Models exposing (FeelId)


type Route
    = ViewFeelsRoute
    | CreateFeelRoute
    | EditFeelRoute String
    | NotFoundRoute


matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf
        [ UrlParser.format ViewFeelsRoute (UrlParser.s "")
        , UrlParser.format ViewFeelsRoute (UrlParser.s "feels")
        , UrlParser.format CreateFeelRoute (UrlParser.s "feel" </> UrlParser.s "new")
        , UrlParser.format EditFeelRoute (UrlParser.s "feel" </> UrlParser.string)
        ]


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> UrlParser.parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
