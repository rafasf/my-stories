module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import Dict exposing (Dict)
import CssStates exposing (knownCssFor)


all : Test
all =
    describe "Priority Coloring"
        [ describe "Known States"
            [ test "Creates map between known states and css class" <|
                \() ->
                    let
                        knownStates =
                            [ "Must Have", "Should Have", "Could Have", "Nice to Have", "Won't Have" ]
                    in
                        Expect.equal (knownCssFor knownStates)
                            (Dict.fromList
                                [ ( "Must Have", "must-have" )
                                , ( "Should Have", "should-have" )
                                , ( "Could Have", "could-have" )
                                , ( "Nice to Have", "nice-to-have" )
                                , ( "Won't Have", "wont-have" )
                                ]
                            )
            ]
        , describe "Unknown States"
            [ test "Creates map with unknown class" <|
                \() ->
                    Expect.equal (knownCssFor [ "blah", "other" ])
                        (Dict.fromList
                            [ ( "blah", "unknown" )
                            , ( "other", "unknown" )
                            ]
                        )
            ]
        ]
