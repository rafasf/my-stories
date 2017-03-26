module Stories exposing (..)

import Html exposing (Html, Attribute, text, li, h3, small)
import Html.Attributes exposing (..)
import String


type alias Model =
    { stories : Story
    }


type Msg
    = Change Model


type alias Story =
    { narrative : String
    , feature : String
    , category : String
    , priority : String
    }


toStoryViewOf : Story -> Html Msg
toStoryViewOf story =
    li [ class "card card-story" ]
        [ h3 [ class "card-narrative" ] [ text story.narrative ]
        , small [ class "card-feature" ] [ text story.feature ]
        ]
