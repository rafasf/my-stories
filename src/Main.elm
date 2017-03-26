module Main exposing (..)

import Html exposing (Html, Attribute, div, section, ul, li, text)
import Html.Attributes exposing (..)
import Dict exposing (Dict)
import StoryGrouping exposing (..)
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
        [ ul []
            (Dict.values
                (Dict.map (\pr cssClass -> li [ class cssClass ] [ text pr ])
                    (knownCssFor
                        (List.map
                            .priority
                            model.stories
                        )
                    )
                )
            )
        , div [] (viewBy "feature" model.stories)
        ]
