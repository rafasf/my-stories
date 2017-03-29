module Main exposing (..)

import Html exposing (Html, Attribute, footer, button, div, section, ul, li, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import Dict.Extra exposing (groupBy)
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
    ( { stories = [], selectedGrouping = Nothing, selectedPriority = Nothing }
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

        SelectGrouping groupingName ->
            ( { model | selectedGrouping = Just groupingName }, Cmd.none )

        ShowAll ->
            ( { model | selectedGrouping = Nothing, selectedPriority = Nothing }, Cmd.none )

        SelectPriority priority ->
            let
                newPriority =
                    if Just priority == model.selectedPriority then
                        Nothing
                    else
                        Just priority
            in
                ( { model | selectedPriority = newPriority }, Cmd.none )


view : Model -> Html Msg
view model =
    section []
        [ ul [ class "fixed-info cards" ] (prioritiesIn model.stories)
        , div [] (viewBy "feature" model)
        , footer []
            [ button [ onClick ShowAll ] [ text "clear selection" ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


prioritiesIn : List Story -> List (Html Msg)
prioritiesIn stories =
    groupBy .priority stories
        |> Dict.map
            (\priority stories ->
                let
                    numberOfStories =
                        " (" ++ (toString (List.length stories)) ++ ")"
                in
                    li
                        [ class ("priority card " ++ (cssClassFor priority))
                        , onClick (SelectPriority (asKebab priority))
                        ]
                        [ text (priority ++ numberOfStories) ]
            )
        |> Dict.values
