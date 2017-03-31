module DynamicCss exposing (..)

import Dict exposing (Dict)


knownPriorities : Dict String String
knownPriorities =
    Dict.fromList
        [ ( "must have", "must-have" )
        , ( "should have", "should-have" )
        , ( "could have", "could-have" )
        , ( "nice to have", "nice-to-have" )
        , ( "won't have", "wont-have" )
        , ( "in scope", "must-have" )
        , ( "not in scope", "should-have" )
        , ( "tbd", "nice-to-have" )
        ]


knownCssFor : List String -> Dict String String
knownCssFor someStates =
    someStates
        |> List.map (\state -> ( state, (cssClassFor state) ))
        |> Dict.fromList


cssClassFor : String -> String
cssClassFor someState =
    Maybe.withDefault
        "unknown"
        (Dict.get (String.toLower someState) knownPriorities)
