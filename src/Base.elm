module Base exposing (..)

import Story exposing (Story)


type alias Model =
    { stories : List Story
    }


model : Model
model =
    { stories = []
    }


type Msg
    = Change Model
