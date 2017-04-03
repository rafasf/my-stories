module Story.Model exposing (..)

import Dict exposing (Dict)
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
        |> withSelectedGroup selectedGroup
        |> groupBy .feature


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


prioritiesIn : List Story -> Dict String Int
prioritiesIn stories =
    stories
        |> groupBy .priority
        |> Dict.map (\_ stories -> List.length stories)


withSelectedGroup : Maybe String -> List Story -> List Story
withSelectedGroup possibleSelectedGroup stories =
    List.filter
        (\story ->
            case possibleSelectedGroup of
                Just selectedGroup ->
                    (selectedGroup == (asKebab story.feature))

                Nothing ->
                    True
        )
        stories
