module Feel.Views exposing (..)

import Feel.List
import FeelForm.View
import Feel.Messages exposing (Msg(..))
import Html.App


list =
    Feel.List.view


new model =
    Html.App.map FeelFormMessage (FeelForm.View.view model.feelForm)
