module Routing exposing (..)

import String
import Navigation
import UrlParser exposing ((</>))
import Feel.Models exposing (FeelId)
import Routes exposing (Route(..))


matchers : UrlParser.Parser (Route -> a) a
matchers =
    UrlParser.oneOf Routes.orderedMatchers


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
