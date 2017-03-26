module Stories exposing (..)

import Html exposing (Html, Attribute, text, li, h3, small)
import Html.Attributes exposing (..)
import String
import Definitions exposing (Story)
import Base exposing (..)


toStoryViewOf : Story -> Html Msg
toStoryViewOf story =
    li [ class "card card-story" ]
        [ h3 [ class "card-narrative" ] [ text story.narrative ]
        , small [ class "card-feature" ] [ text story.feature ]
        ]
