module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region

background_color : Color
background_color = Element.rgb 0.1686 0.1686 0.1686

type alias Model =
    {

    }

init : Model
init  = Model

view model =
 Element.layout
        [Background.color background_color
        , Font.size  20
        ]
    <|
        Element.column
        [
        ]
        [el
            [ Region.heading 1
                            , moveRight 50
                            , moveDown 50
                            , Font.size 72
                            , Font.extraBold
                            , Font.family
                                [ Font.external{
                                    url = "https://fonts.googleapis.com/css2?family=Fredoka:wght@300&display=swap"
                                    , name = "Fredoka"
                                    }
                                ]
                            ]
                            (text "Fabled Blog")
        ]


update : msg -> Model -> Model
update msg model = model

main =
    Browser.sandbox
    {init = init
    ,view = view
    ,update = update
    }