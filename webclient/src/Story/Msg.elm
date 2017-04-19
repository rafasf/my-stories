module Story.Msg exposing (..)

import Http
import Story.Model exposing (Story)


type Msg
    = FetchStories
    | StoriesLoaded (Result Http.Error (List Story))
    | SelectGroup String
    | SelectPriority String
