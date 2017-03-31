module Base exposing (..)

import Story.Model exposing (Story)


type alias Model =
    { stories : List Story
    , selectedGroup : Maybe String
    , selectedPriority : Maybe String
    }


model : Model
model =
    { selectedGroup = Nothing
    , selectedPriority = Nothing
    , stories =
        [ { category = "Cat 1"
          , feature = "Feat 1"
          , narrative = "Nar 1"
          , priority = "Must Have"
          }
        , { category = "Cat 1"
          , feature = "Feat 1"
          , narrative = "Nar 2"
          , priority = "Should Have"
          }
        , { category = "Cat 2"
          , feature = "Feat 2"
          , narrative = "Nar 3"
          , priority = "Could Have"
          }
        ]
    }
