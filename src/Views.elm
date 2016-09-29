module Views exposing (..)

import Html exposing (..)
import Html.App
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Models exposing (Model)
import Routing exposing (Route(..))
import Messages exposing (Msg(..))
import Feel.Messages exposing (Msg(ShowFeelsOverview, ShowAddFeel))
import Feel.List
import FeelForm.View


type alias Url =
    String


type alias Icon =
    String


view : Model -> Html Messages.Msg
view model =
    div []
        [ navigation model
        , div [ class "container" ]
            [ section [ class "section" ]
                [ page model ]
            , footer
            ]
        ]


link : String -> Messages.Msg -> List (Html.Html Messages.Msg) -> Html Messages.Msg
link classes action content =
    a [ class classes, onClick action ] content


tabLink : Model -> Route -> Messages.Msg -> String -> Html Messages.Msg
tabLink model route action label =
    let
        classes =
            if model.route == route then
                "nav-item is-tab is-active"
            else
                "nav-item is-tab"
    in
        link classes action [ text label ]


buttonLink : Messages.Msg -> Icon -> String -> Html Messages.Msg
buttonLink action icon label =
    a [ class "button is-primary", onClick action ]
        [ span [ class "icon is-small" ]
            [ i [ class <| "fa " ++ icon ]
                []
            ]
        , span []
            [ text label ]
        ]


brand : Html Messages.Msg
brand =
    a
        [ class "nav-item is-brand"
        , href "/#"
        , style [ ( "margin-left", "40px" ), ( "margin-right", "40px" ) ]
        ]
        [ h1 [ class "title is-primary is-3" ] [ text "Feels" ]
        ]


navigation : Model -> Html Messages.Msg
navigation model =
    let
        addFeelButton =
            if model.route == ViewFeelsRoute then
                Just <| buttonLink (FeelMessage ShowAddFeel) "fa-heart" "Log a Feel"
            else
                Nothing

        contextualButtons =
            List.filterMap identity [ addFeelButton ]
    in
        nav [ class "nav container has-shadow" ]
            [ div [ class "nav-left" ]
                [ brand
                , div [ class "tabs is-medium" ]
                    [ ul []
                        [ li [] [ tabLink model ViewFeelsRoute (FeelMessage ShowFeelsOverview) "Feel Log" ]
                        ]
                    ]
                ]
            , div [ class "nav-right nav-menu" ]
                [ span [ class "nav-item" ]
                    contextualButtons
                ]
            ]


footer : Html Messages.Msg
footer =
    div [ class "footer" ]
        [ div [ class "container" ]
            [ div [ class "content has-text-centered" ]
                [ p []
                    [ text "Made by "
                    , a [ href "https://www.github.com/bjrnt" ]
                        [ text "Björn Tegelund" ]
                    ]
                ]
            ]
        ]


page : Model -> Html Messages.Msg
page model =
    case model.route of
        ViewFeelsRoute ->
            Html.App.map FeelMessage (Feel.List.view model.feels)

        CreateFeelRoute ->
            Html.App.map FeelFormMessage (FeelForm.View.view model.feelFormState)

        NotFoundRoute ->
            notFoundView


notFoundView : Html Messages.Msg
notFoundView =
    div [] [ text "Not found" ]
