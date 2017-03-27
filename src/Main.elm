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
    Html.program
        { init = init []
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : List Story -> ( Model, Cmd Msg )
init initialStories =
    ( { stories = [] }
    , fetchStories
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchStories ->
            ( model, fetchStories )

        StoriesLoaded (Ok stories) ->
            ( { model | stories = stories }, Cmd.none )

        StoriesLoaded (Err _) ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    section []
        [ ul [] (prioritiesIn model.stories)
        , div [] (viewBy "feature" model.stories)
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


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
