module Routes exposing (..)

import UrlParser exposing ((</>))
import Feel.Commands
import Messages exposing (Msg(..))
import FeelForm.Commands
import FeelForm.Messages exposing (Msg(..))
import Feel.Messages exposing (Msg(..))
import Feathers


type Route
    = ViewFeelsRoute
    | CreateFeelRoute
    | EditFeelRoute String
    | NotFoundRoute


orderedMatchers : List (UrlParser.Parser (Route -> a) a)
orderedMatchers =
    [ UrlParser.format ViewFeelsRoute (UrlParser.s "")
    , UrlParser.format ViewFeelsRoute (UrlParser.s "feels")
    , UrlParser.format CreateFeelRoute (UrlParser.s "feel" </> UrlParser.s "new")
    , UrlParser.format EditFeelRoute (UrlParser.s "feel" </> UrlParser.string)
    , UrlParser.format NotFoundRoute (UrlParser.s "404")
    ]


onRouteEnter : Route -> Cmd Messages.Msg
onRouteEnter route =
    case route of
        ViewFeelsRoute ->
            Cmd.batch [ Feathers.getFeels () ]

        EditFeelRoute id ->
            Cmd.map FeelMessage
                <| Feel.Commands.fetchById id (\x -> FeelFormMessage (InitFrom x))

        CreateFeelRoute ->
            Cmd.map FeelMessage
                <| Cmd.map FeelFormMessage
                <| Cmd.batch
                    [ FeelForm.Commands.generateDescriptionPlaceholder
                    , FeelForm.Commands.generateTimestamp
                    ]

        NotFoundRoute ->
            Cmd.none
