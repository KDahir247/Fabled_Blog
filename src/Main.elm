module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Url
import Platform.Cmd exposing (none)
import Platform.Sub exposing (none)

background_color : Color
background_color = Element.rgb 0.1686 0.1686 0.1686

type Msg =
     ClickedLink Browser.UrlRequest
    | UrlChanged Url.Url

type alias Model = {}

init () url navKey = (Model, Platform.Cmd.none)

view : Model -> Browser.Document Msg
view model =
    {
    title = "Fable Blog"
    , body = [
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
                                  ]
    }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Platform.Cmd.none)

subscription model = Platform.Sub.none

main = Browser.application
    {init = init
    ,view = view
    , update = update
    , subscriptions = subscription
    , onUrlChange = UrlChanged
    , onUrlRequest = ClickedLink
    }