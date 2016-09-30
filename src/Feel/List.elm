module Feel.List exposing (..)

import Feel.Messages exposing (..)
import Feel.Models exposing (Feel)
import Feel.Mood
import Html exposing (..)
import Html.Attributes exposing (..)
import Date
import Date.Extra
import String
import Components exposing (buttonLink)


{-|
TODO: check out
http://package.elm-lang.org/packages/justinmimbs/elm-date-extra/2.0.0/Date-Extra#
-}
viewTimestamp : Date.Date -> String
viewTimestamp timestamp =
    let
        hour =
            toString <| Date.hour timestamp

        minute =
            toString <| Date.minute timestamp

        day =
            toString <| Date.day timestamp

        month =
            toString <| Date.month timestamp

        year =
            toString <| Date.year timestamp
    in
        hour ++ ":" ++ minute ++ " - " ++ String.join " " [ day, month, year ]


viewFeel : Feel -> Html Msg
viewFeel feel =
    div [ class "card is-fullwidth" ]
        [ div [ class "card-content" ]
            [ div [ class "content" ]
                [ div [ class "columns is-mobile" ]
                    [ div [ class "column is-one-quarter" ]
                        [ Feel.Mood.view feel.mood
                        ]
                    , div [ class "column is-two-quarters" ]
                        [ p []
                            [ strong [] [ text "Thoughts" ]
                            , br [] []
                            , text feel.description
                            ]
                        , p []
                            [ small [] [ text <| viewTimestamp feel.timestamp ]
                            ]
                        ]
                    ]
                ]
            ]
        ]


view : List Feel -> Html Msg
view feels =
    let
        dateSortedFeels =
            List.sortWith dateComparer feels

        addFeelButton =
            buttonLink ShowAddFeel "fa-heart" "Log a Feel"
    in
        div []
            ([ h1 [ class "title is-3" ]
                [ text "Recent Feels" ]
             ]
                ++ (List.map viewFeel dateSortedFeels)
                ++ [ br [] []
                   , br [] []
                   , nav [ class "level" ]
                        [ div [ class "level-item has-text-centered" ]
                            [ addFeelButton ]
                        ]
                   ]
            )


{-|
Order is set to descending by switching argument places
-}
dateComparer : Feel -> Feel -> Order
dateComparer x y =
    Date.Extra.compare y.timestamp x.timestamp
