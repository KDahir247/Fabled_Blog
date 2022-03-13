module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Element.Region as Region
import Url
import Platform.Cmd exposing (none)
import Platform.Sub exposing (none)
import Element.Border exposing (..)
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
                                      ,scrollbarY
                                      ]
                                  <|
                                      Element.column
                                      [
                                      Element.width fill,
                                      Element.height fill
                                      ]
                                      [el
                                          [ Region.heading 1
                                                          , paddingXY 70 70
                                                          , Font.size 72
                                                          , Font.extraBold
                                                          , Font.color (rgb255 179 0 0)
                                                          , Font.glow (rgb255 255 220 26) 1.5
                                                          , Font.family
                                                              [ Font.external{
                                                                  url = "https://fonts.googleapis.com/css2?family=Fredoka:wght@300&display=swap"
                                                                  , name = "Fredoka"
                                                                  }
                                                              ]
                                          ]
                                            <|
                                                text "Fabled Blog"
                                          ,
                                          Element.row
                                          [
                                          Element.width fill
                                          ,Background.color (rgb 0.149 0.1569 0.149)
                                          ,Element.Border.rounded 50
                                          , Element.Border.color (rgb255 255 255 255)
                                          ]
                                          [
                                          Element.el
                                          [
                                          ] (text "hello")
                                          ]
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