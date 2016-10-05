module Feel.List exposing (..)

import Feel.Messages exposing (..)
import Feel.Models exposing (Feel, Model)
import Feel.Mood
import Html exposing (..)
import Html.Attributes exposing (..)
import Date
import Date.Extra
import String
import Components exposing (buttonLink)


viewTimestamp : Date.Date -> String
viewTimestamp timestamp =
    Date.Extra.toFormattedString "hh:mm a - dd MMMM y" timestamp


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


view : Model -> Html Msg
view model =
    let
        dateSortedFeels =
            List.sortWith dateComparer model.feels

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
