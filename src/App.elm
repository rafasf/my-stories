module App exposing (..)

import Html exposing (Html, Attribute, footer, button, div, section, ul, li, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Dict exposing (Dict)
import Dict.Extra exposing (groupBy)
import Http exposing (get, send)
import Base exposing (..)
import Story.Model exposing (Story, groupedBy, prioritiesIn)
import Story.View exposing (toGroupView, priorityViewOf)
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
            "http://localhost:8000/my-stories-a7fde-export.json"
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

        ShowAll ->
            ( { model | selectedGroup = Nothing, selectedPriority = Nothing }, Cmd.none )

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
        [ ul [ class "fixed-info cards" ]
            ((prioritiesIn model.stories)
                |> Dict.map (\p ns -> priorityViewOf p ns)
                |> Dict.values
            )
        , div [] <|
            ((groupedBy "feature" model.stories model.selectedGroup model.selectedPriority)
                |> Dict.map toGroupView
                |> Dict.values
            )
        , footer []
            [ button [ onClick ShowAll ] [ text "clear selection" ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
