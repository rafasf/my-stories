module Base exposing (..)

import Definitions exposing (Story)


type alias Model =
    { stories : List Story
    }


model : Model
model =
    { stories = []
    }


type Msg
    = Change Model
