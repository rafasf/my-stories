module App exposing (..)

import Html exposing (Html, Attribute, button, div, section, ul, li, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import Dict.Extra exposing (groupBy)
import Http exposing (get, send)
import Base exposing (..)
import Story.Model exposing (Story, groupedBy, prioritiesIn, summaryFor)
import Story.View exposing (toGroupView, priorityViewOf, summaryViewOf)
import Story.Msg exposing (..)
import Story.Decoder exposing (storyDecoder)
import Strings exposing (asKebab)
import DynamicCss exposing (cssClassFor)


main =
    Html.program
        { init = init []
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : List Story -> ( Model, Cmd Msg )
init initialStories =
    ( { stories = [], selectedGroup = Nothing, selectedPriority = Nothing }
    , fetchStories
    )


fetchStories : Cmd Msg
fetchStories =
    let
        url =
            "http://localhost:3000/api/stories"
    in
        Http.send StoriesLoaded (Http.get url storyDecoder)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchStories ->
            ( model, fetchStories )

        StoriesLoaded (Ok stories) ->
            ( { model | stories = stories }, Cmd.none )

        StoriesLoaded (Err _) ->
            ( model, Cmd.none )

        SelectGroup groupingName ->
            let
                newGroup =
                    if Just groupingName == model.selectedGroup then
                        Nothing
                    else
                        Just groupingName
            in
                ( { model | selectedGroup = newGroup }, Cmd.none )

        SelectPriority priority ->
            let
                newPriority =
                    if Just priority == model.selectedPriority then
                        Nothing
                    else
                        Just priority
            in
                ( { model | selectedPriority = newPriority }, Cmd.none )


priorityList : Model -> Html Msg
priorityList model =
    prioritiesIn model.stories
        |> Dict.map (\priority numberOfStories -> priorityViewOf priority numberOfStories)
        |> Dict.values
        |> (\priorities -> [ (summaryViewOf (summaryFor model.stories)) ] ++ priorities)
        |> ul [ class "fixed-info cards" ]


storyList : Model -> Html Msg
storyList model =
    groupedBy "feature" model.stories model.selectedGroup model.selectedPriority
        |> Dict.map toGroupView
        |> Dict.values
        |> section [ class "features" ]


view : Model -> Html Msg
view model =
    section []
        [ priorityList model
        , storyList model
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
