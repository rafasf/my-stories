module Stories exposing (..)

import Html exposing (Html, Attribute, text, li, h3, small)
import Html.Attributes exposing (..)
import String
import Http
import Json.Decode exposing (Decoder, string, field, map4)
import Definitions exposing (Story)
import CssStates exposing (cssClassFor)
import Base exposing (..)


toStoryViewOf : Story -> Html Msg
toStoryViewOf story =
    li [ class ("card card-story " ++ (cssClassFor story.priority)) ]
        [ h3 [ class "card-narrative" ] [ text story.narrative ]
        , small [ class "card-feature" ] [ text story.feature ]
        ]


fetchStories : Cmd Msg
fetchStories =
    let
        url =
            "http://localhost:8000/my-stories-a7fde-export.json"
    in
        Http.send StoriesLoaded (Http.get url storyDecoder)


storyDecoder : Decoder (List Story)
storyDecoder =
    Json.Decode.list
        (map4 Story
            (field "narrative" string)
            (field "feature" string)
            (field "category" string)
            (field "priority" string)
        )
