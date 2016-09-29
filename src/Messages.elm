module Messages exposing (..)

import Feel.Messages
import FeelForm.Messages


type Msg
    = FeelMessage Feel.Messages.Msg
    | FeelFormMessage FeelForm.Messages.Msg
