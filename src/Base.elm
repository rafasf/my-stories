module Base exposing (..)

import Http
import Definitions exposing (Story)


type alias Model =
    { stories : List Story
    , selectedGrouping : Maybe String
    , selectedPriority : Maybe String
    }


model : Model
model =
    { selectedGrouping = Nothing
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


type Msg
    = FetchStories
    | StoriesLoaded (Result Http.Error (List Story))
    | SelectGrouping String
    | ShowAll
    | SelectPriority String
