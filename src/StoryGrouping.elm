module StoryGrouping exposing (..)

import Html exposing (Html, Attribute, section, text, ul, p, h2)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import Dict.Extra exposing (groupBy)
import String
import Regex exposing (replace, regex)
import Definitions exposing (Story)
import Base exposing (..)
import Stories exposing (..)


viewBy : String -> Model -> List (Html Msg)
viewBy field { stories, selectedGrouping, selectedPriority } =
    stories
        |> withPriorityLike selectedPriority
        |> groupBy .feature
        |> Dict.filter (onlySelectedGroup selectedGrouping)
        |> Dict.map toGroupingView
        |> Dict.values


toGroupingView : String -> List Story -> Html Msg
toGroupingView groupingField stories =
    let
        numberOfStories =
            " (" ++ (toString (List.length stories)) ++ ")"

        groupName =
            (asKebab groupingField)
    in
        section [ class "feature" ]
            [ h2
                [ class "feature-name", onClick (SelectGrouping groupName) ]
                [ text (groupingField ++ numberOfStories) ]
            , ul [ class "cards" ] (List.map toStoryViewOf stories)
            ]


asKebab : String -> String
asKebab aString =
    (String.toLower (replace Regex.All (regex "\\s+") (\_ -> "-") aString))


onlySelectedGroup : Maybe String -> String -> List Story -> Bool
onlySelectedGroup possibleSelectedGroup groupName stories =
    case possibleSelectedGroup of
        Just selectedGroup ->
            ((asKebab groupName) == selectedGroup)

        Nothing ->
            True


withPriorityLike : Maybe String -> List Story -> List Story
withPriorityLike possibleSelectedPrioirty stories =
    List.filter
        (\story ->
            case possibleSelectedPrioirty of
                Just selectedPriority ->
                    ((asKebab story.priority) == selectedPriority)

                Nothing ->
                    True
        )
        stories
