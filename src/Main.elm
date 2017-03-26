module Main exposing (..)

import Html exposing (Html, Attribute, div, section, ul, li, text)
import Html.Attributes exposing (..)
import Dict exposing (Dict)
import StoryGrouping exposing (..)
import Definitions exposing (Story)
import Stories exposing (..)
import CssStates exposing (..)
import Base exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | stories = newContent.stories }


view : Model -> Html Msg
view model =
    section []
        [ ul [] (prioritiesIn model.stories)
        , div [] (viewBy "feature" model.stories)
        ]


prioritiesIn : List Story -> List (Html Msg)
prioritiesIn stories =
    let
        priorities =
            (List.map
                .priority
                model.stories
            )
    in
        (Dict.values
            (Dict.map (\priority cssClass -> li [ class cssClass ] [ text priority ])
                (knownCssFor priorities)
            )
        )
