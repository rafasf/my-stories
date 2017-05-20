module Story.ViewTest exposing (..)

import Test exposing (..)
import Expect
import Html exposing (Html, Attribute, section, text, div, h1, h2, h3, p, small, ul, li)
import Html.Attributes exposing (..)
import Story.Model exposing (Story)
import Story.View exposing (..)


all : Test
all =
    describe "Stories"
        [ describe "HTML Creation"
            [ test "for one story" <|
                let
                    story =
                        { narrative = "Some good description"
                        , feature = "Feat"
                        , priority = "Must Have"
                        , category = "blah"
                        }
                in
                    \() ->
                        Expect.equal (storyViewOf story)
                            (li
                                [ class "card card-story must-have" ]
                                [ h3 [ class "card-narrative" ] [ text "Some good description" ]
                                , small [ class "card-feature" ] [ text "Feat" ]
                                ]
                            )
            , test "priority list" <|
                \() ->
                    Expect.equal
                        (priorityViewOf "Must Have" 3)
                        (li
                            [ class "priority card must-have" ]
                            [ text "Must Have (3)" ]
                        )
            ]
        ]
