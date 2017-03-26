module StoryGrouping exposing (..)

import Html exposing (Html, Attribute, section, text, ul, h2)
import Html.Attributes exposing (..)
import Dict exposing (Dict)
import Dict.Extra exposing (groupBy)
import String
import Definitions exposing (Story)
import Base exposing (..)
import Stories exposing (..)


viewBy : String -> List Story -> List (Html Msg)
viewBy field stories =
    groupBy .feature stories
        |> Dict.map toGroupingView
        |> Dict.values


toGroupingView : String -> List Story -> Html Msg
toGroupingView groupingField stories =
    section [ class "feature" ]
        [ h2 [ class "feature-name" ] [ text groupingField ]
        , ul [ class "cards" ] (List.map toStoryViewOf stories)
        ]
