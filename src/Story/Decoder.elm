module Story.Decoder exposing (storyDecoder)

import Json.Decode exposing (Decoder, field, list, map4, string)
import Story.Model exposing (Story)


storyDecoder : Decoder (List Story)
storyDecoder =
    list
        (map4 Story
            (field "narrative" string)
            (field "feature" string)
            (field "category" string)
            (field "priority" string)
        )
