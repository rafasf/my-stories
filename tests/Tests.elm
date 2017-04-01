module Tests exposing (..)

import Test exposing (..)
import Story.ModelTest
import Story.ViewTest
import DynamicCssTest
import MainTest


all : Test
all =
    describe "my-stories"
        [ Story.ModelTest.all
        , DynamicCssTest.all
        , MainTest.all
        ]
