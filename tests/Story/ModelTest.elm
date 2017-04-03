module Story.ModelTest exposing (..)

import Test exposing (..)
import Expect
import Dict
import Story.Model exposing (..)


stories : List Story
stories =
    [ { narrative = "n1"
      , feature = "f1"
      , category = "c1"
      , priority = "must-have"
      }
    , { narrative = "n4"
      , feature = "f4"
      , category = "c4"
      , priority = "should-have"
      }
    , { narrative = "n2"
      , feature = "f1"
      , category = "c2"
      , priority = "must-have"
      }
    ]


all : Test
all =
    describe "Story"
        [ test "returns only stories with given priority" <|
            \() ->
                Expect.equal (withPriority (Just "must-have") stories)
                    [ { narrative = "n1"
                      , feature = "f1"
                      , category = "c1"
                      , priority = "must-have"
                      }
                    , { narrative = "n2"
                      , feature = "f1"
                      , category = "c2"
                      , priority = "must-have"
                      }
                    ]
        , test "returns stories matching desired feature" <|
            \() ->
                Expect.equal (withSelectedGroup (Just "f4") stories)
                    [ { narrative = "n4"
                      , feature = "f4"
                      , category = "c4"
                      , priority = "should-have"
                      }
                    ]
        , test "returns only desired stories groups by feature" <|
            \() ->
                Expect.equal (groupedBy "property" stories (Just "f4") (Just "should-have"))
                    (Dict.fromList
                        [ ( "f4"
                          , [ { narrative = "n4"
                              , feature = "f4"
                              , category = "c4"
                              , priority = "should-have"
                              }
                            ]
                          )
                        ]
                    )
        , test "returns priorites with number of stories in it" <|
            \() ->
                Expect.equal (prioritiesIn stories)
                    (Dict.fromList
                        [ ( "must-have", 2 )
                        , ( "should-have", 1 )
                        ]
                    )
        ]
