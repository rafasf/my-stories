module CssStates exposing (..)

import Dict exposing (Dict)


allKnownStates : Dict String String
allKnownStates =
    Dict.fromList
        [ ( "must have", "must-have" )
        , ( "should have", "should-have" )
        , ( "could have", "could-have" )
        , ( "nice to have", "nice-to-have" )
        , ( "won't have", "wont-have" )
        ]


knownCssFor : List String -> Dict String String
knownCssFor someStates =
    Dict.fromList
        (List.map
            (\state ->
                ( state, (Maybe.withDefault "unknown" (Dict.get (String.toLower state) allKnownStates)) )
            )
            someStates
        )
