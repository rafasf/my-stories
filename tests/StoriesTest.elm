module StoriesTest exposing (..)

import Test exposing (..)
import Expect
import Html exposing (Html, Attribute, section, text, div, h1, h2, h3, p, small, ul, li)
import Html.Attributes exposing (..)
import Story exposing (Story)
import Stories exposing (..)


all : Test
all =
    describe "Stories"
        [ describe "HTML Creation"
            [ test "for one story" <|
                let
                    story : Story
                    story =
                        { narrative = "Some good description"
                        , feature = "Feat"
                        , priority = "some"
                        , category = "blah"
                        }
                in
                    \() ->
                        Expect.equal (toStoryViewOf story)
                            (li
                                [ class "card card-story" ]
                                [ h3 [ class "card-narrative" ] [ text "Some good description" ]
                                , small [ class "card-feature" ] [ text "Feat" ]
                                ]
                            )
            ]
        ]
