module Story.Model exposing (Story, groupedBy, withPriority)

import Dict
import Dict.Extra exposing (groupBy)
import Strings exposing (asKebab)


type alias Story =
    { narrative : String
    , feature : String
    , category : String
    , priority : String
    }


groupedBy : String -> List Story -> Maybe String -> Maybe String -> Dict.Dict String (List Story)
groupedBy property stories selectedGroup selectedPriority =
    stories
        |> withPriority selectedPriority
        |> groupBy .feature
        |> Dict.filter (withSelectedGroup selectedGroup)


withPriority : Maybe String -> List Story -> List Story
withPriority possiblePriority stories =
    List.filter
        (\story ->
            case possiblePriority of
                Just selectedPriority ->
                    (selectedPriority == (asKebab story.priority))

                Nothing ->
                    True
        )
        stories


withSelectedGroup : Maybe String -> String -> List Story -> Bool
withSelectedGroup possibleSelectedGroup groupName stories =
    case possibleSelectedGroup of
        Just selectedGroup ->
            (asKebab groupName == selectedGroup)

        Nothing ->
            True
