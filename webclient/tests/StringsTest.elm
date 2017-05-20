module StringsTest exposing (..)

import Test exposing (..)
import Expect
import Strings


all : Test
all =
    describe "Strings"
        [ test "transformation to kebab case" <|
            Expect.equal (asKebab "Some Text") "some-text"
        ]
