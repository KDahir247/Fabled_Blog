module Menu exposing (..)

{-


-}

import Html exposing (Html, a, div, footer)
import Html.Attributes exposing (class, href)


type Page = Home
    | Technologies
     | Artwork
     | Showcase
     | AboutMe






viewFooter : Html msg
viewFooter = footer [] [
    div
    [class "container"
    ]
    [a
        [ class "a"
        , href "#"
        ]
        [Html.text "fabled blog"
        ]
    ]
   ]