module Story.View exposing (..)

import Html exposing (Html, h2, h3, li, section, small, span, ul, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import Story.Model exposing (Story, StoriesSummary)
import Story.Msg exposing (..)
import DynamicCss exposing (cssClassFor)
import Strings exposing (asKebab)


storyViewOf : Story -> Html Msg
storyViewOf story =
    li [ class ("card card-story " ++ (cssClassFor story.priority)) ]
        [ h3 [ class "card-narrative" ] [ text story.narrative ]
        , small [ class "card-feature" ] [ text story.feature ]
        ]


toGroupView : String -> List Story -> Html Msg
toGroupView groupingField stories =
    let
        title =
            String.join "" [ groupingField, " (", (toString (List.length stories)), ")" ]

        groupName =
            (asKebab groupingField)
    in
        section [ class "feature" ]
            [ h2
                [ class "feature-name", onClick (SelectGroup groupName) ]
                [ text title ]
            , ul [ class "cards" ] <| List.map storyViewOf stories
            ]


priorityViewOf : String -> Int -> Html Msg
priorityViewOf priority numberOfStories =
    li
        [ class ("priority card " ++ (cssClassFor priority))
        , onClick (SelectPriority (asKebab priority))
        ]
        [ text (priority ++ " (" ++ (toString numberOfStories) ++ ")") ]


summaryViewOf : StoriesSummary -> Html Msg
summaryViewOf summary =
    let
        projectName =
            "Summary"

        summaryText =
            " (Stories: "
                ++ (toString summary.numberOfStories)
                ++ ", Features: "
                ++ (toString summary.numberOfFeatures)
                ++ ")"
    in
        li [ class "card summary" ]
            [ text (projectName ++ summaryText) ]
