module Feel.Views exposing (..)

import Feel.List
import FeelForm.View
import Feel.Messages exposing (Msg(..))
import Html.App
import Feel.Models exposing (Model)
import Html exposing (Html)


list : Model -> Html Msg
list =
    Feel.List.view


new : Model -> Html Msg
new model =
    Html.App.map FeelFormMessage (FeelForm.View.view model.feelForm)


edit : Model -> Html Msg
edit model =
    Html.App.map FeelFormMessage (FeelForm.View.view model.feelForm)
