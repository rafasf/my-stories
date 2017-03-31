module Tests exposing (..)

import Test exposing (..)
import Story.ModelTest
import Story.ViewTest
import DynamicCssTest


all : Test
all =
    describe "my-stories"
        [ Story.ModelTest.all
        , DynamicCssTest.all
        ]
