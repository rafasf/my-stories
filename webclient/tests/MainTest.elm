module MainTest exposing (..)

import Test exposing (..)
import Expect
import Tuple
import App exposing (..)
import Base exposing (model)
import Story.Msg exposing (..)


all : Test
all =
    describe "Update"
        [ describe "Group Selection"
            [ test "selects a group" <|
                \() ->
                    model
                        |> update (SelectGroup "f1")
                        |> Tuple.first
                        |> .selectedGroup
                        |> Expect.equal (Just "f1")
            , test "removes selected group if the same" <|
                let
                    modelWithGroup =
                        { model | selectedGroup = Just "g" }
                in
                    \() ->
                        modelWithGroup
                            |> update (SelectGroup "g")
                            |> Tuple.first
                            |> .selectedGroup
                            |> Expect.equal Nothing
            ]
        , describe "Priority Selection"
            [ test "selects a priority" <|
                \() ->
                    model
                        |> update (SelectPriority "must")
                        |> Tuple.first
                        |> .selectedPriority
                        |> Expect.equal (Just "must")
            , test "removes selected priority if the same" <|
                let
                    modelWithPriority =
                        { model | selectedPriority = Just "one" }
                in
                    \() ->
                        modelWithPriority
                            |> update (SelectPriority "one")
                            |> Tuple.first
                            |> .selectedPriority
                            |> Expect.equal Nothing
            ]
        ]
