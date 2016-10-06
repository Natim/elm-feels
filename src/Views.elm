module Views exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Models exposing (Model)
import Routes exposing (Route(..))
import Messages exposing (Msg(..))
import Feel.Messages exposing (Msg(ShowFeelsOverview, ShowAddFeel))
import Feel.Views
import Components exposing (actionLink)


view : Model -> Html Messages.Msg
view model =
    div []
        [ navigation model
        , div [ class "container" ]
            [ section [ class "section" ]
                [ viewFor model ]
            , footer
            ]
        ]


tabLink : Model -> Route -> Messages.Msg -> String -> Html Messages.Msg
tabLink { route } targetRoute action label =
    let
        classes =
            "nave-item is-tab"
                ++ if route == targetRoute then
                    " is-active"
                   else
                    ""
    in
        actionLink classes action [ text label ]


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
    nav [ class "nav container has-shadow" ]
        [ div [ class "nav-left" ]
            [ brand
            , div [ class "tabs is-medium" ]
                [ ul []
                    [ li []
                        [ tabLink model ViewFeelsRoute (FeelMessage ShowFeelsOverview) "Feel Log" ]
                    ]
                ]
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


viewFor : Model -> Html Messages.Msg
viewFor model =
    case model.route of
        ViewFeelsRoute ->
            Html.App.map FeelMessage (Feel.Views.list model.feelModel)

        EditFeelRoute id ->
            Html.App.map FeelMessage (Feel.Views.edit model.feelModel)

        CreateFeelRoute ->
            Html.App.map FeelMessage (Feel.Views.new model.feelModel)

        NotFoundRoute ->
            div [] [ text "Not found" ]
