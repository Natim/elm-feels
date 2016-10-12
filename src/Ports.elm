port module Ports exposing (..)

port onTestLol : String -> Cmd msg

port foobar : (String -> msg) -> Sub msg
