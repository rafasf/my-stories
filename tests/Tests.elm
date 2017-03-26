module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import StoriesTest
import CssStatesTest


all : Test
all =
    describe "my-stories"
        [ StoriesTest.all
        , CssStatesTest.all
        ]
