module StoryGroupingTest exposing (..)

import Test exposing (..)
import Expect
import Html exposing (Html, Attribute, section, text, div, h1, h2, h3, p, small, ul, li)
import Html.Attributes exposing (..)
import Stories exposing (toStoryViewOf)
import StoryGrouping exposing (..)


all : Test
all =
    describe "Story Grouping"
        [ describe "by feature"
            [ test "HTML creation" <|
                let
                    featureOneStories =
                        [ { category = "Cat 1"
                          , feature = "Feat 1"
                          , narrative = "Nar 1"
                          , priority = "Must Have"
                          }
                        , { category = "Cat 1"
                          , feature = "Feat 1"
                          , narrative = "Nar 2"
                          , priority = "Should Have"
                          }
                        ]

                    featureTwoStories =
                        [ { category = "Cat 2"
                          , feature = "Feat 2"
                          , narrative = "Nar 3"
                          , priority = "Could Have"
                          }
                        ]

                    stories =
                        List.concat [ featureOneStories, featureTwoStories ]
                in
                    \() ->
                        Expect.equal (viewBy "feature" stories)
                            ([ section [ class "feature" ]
                                [ h2 [ class "feature-name" ] [ text "Feat 1" ]
                                , ul [ class "cards" ] (List.map toStoryViewOf featureOneStories)
                                ]
                             , section [ class "feature" ]
                                [ h2 [ class "feature-name" ] [ text "Feat 2" ]
                                , ul [ class "cards" ] (List.map toStoryViewOf featureTwoStories)
                                ]
                             ]
                            )
            ]
        ]
