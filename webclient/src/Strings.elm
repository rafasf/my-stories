module Strings exposing (asKebab)

import Regex exposing (regex, replace)


asKebab : String -> String
asKebab aString =
    (String.toLower (replace Regex.All (regex "\\s+") (\_ -> "-") aString))
