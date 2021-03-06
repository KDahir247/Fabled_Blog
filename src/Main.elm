module Main exposing (..)


import Bootstrap.Button as Button
import  Bootstrap.ButtonGroup as ButtonGroup
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Text as Text
import Bootstrap.Utilities.Spacing as Spacing
import Browser
import Browser.Navigation as Navigation
import Browser.Navigation
import Color
import Html exposing (Html, div, h3, img, text)
import Html.Attributes exposing (class, href, src, style)
import Menu exposing (viewFooter)
import Url exposing (Url)
import Platform.Cmd
import Bootstrap.Navbar as Navbar
import Bootstrap.ButtonGroup

type alias Flags =
    {}


type Msg =
     ClickedLink Browser.UrlRequest
    | UrlChanged Url.Url
    | NavbarMsg Navbar.State


type alias Model =
    { navKey : Navigation.Key
    , navState : Navbar.State
    }

init : Flags -> Url -> Navigation.Key -> (Model, Cmd Msg)
init _ _ navKey =
    let
            (navState, navbarCmd)
                = Navbar.initialState NavbarMsg
        in
            ({navKey = navKey, navState = navState}, navbarCmd )



view : Model -> Browser.Document Msg
view model =
    {
    title = "Fable Blog"
    , body =
        [
        div
        [
           {- style "background-color" "#454545"-}
        ]
            [ menu model
            , social_platform model
            , pageHome model
            , viewFooter
            ]
        ]
    }

menu : Model -> Html Msg
menu model = Navbar.config NavbarMsg
    |>  Navbar.withAnimation
    |> Navbar.container
    |> Navbar.darkCustom (Color.rgb255 69 69 69)
    |> Navbar.brand [href "#"] [Html.text "Fabled Blog"]
    |> Navbar.items
        [
        Navbar.dropdown
        {id = "Technologies"
        ,toggle = Navbar.dropdownToggle [] [Html.text "Technologies"]
        ,items =
                [ Navbar.dropdownHeader [Html.text "Software"]
                , Navbar.dropdownItem [href "#"] [Html.text "Game Engine"] {-We want to have a group to represent different parts-}
                , Navbar.dropdownItem [href "#"] [Html.text "Compiler/Interpreter"]
                , Navbar.dropdownDivider
                , Navbar.dropdownHeader [Html.text "Hardware"]
                , Navbar.dropdownItem [href "#"] [Html.text "CPU Architecture"]
                , Navbar.dropdownItem [href "#"] [Html.text "GPU Architecture"]

                ]
        }
        , Navbar.dropdown
        {id = "Artwork"
        ,toggle = Navbar.dropdownToggle [] [Html.text "Artwork"]
        ,items =
            [ Navbar.dropdownHeader [Html.text "Visual"]
            , Navbar.dropdownItem[href "#"] [Html.text "Illustration"]
            , Navbar.dropdownItem[href "#"] [Html.text "Studies"]
            , Navbar.dropdownDivider
            , Navbar.dropdownHeader [Html.text "Content"]
            , Navbar.dropdownItem[href "#"] [Html.text "Tutorial"]
            , Navbar.dropdownItem[href "#"] [Html.text "Blog"]
            ]
        }
        , Navbar.itemLink [href "#"] [Html.text "Showcase"]
        , Navbar.itemLink [href "#"] [Html.text "About Me"]
        ]
    |> Navbar.view model.navState

{-Might remove Remove ButtonGroup and keep it as individual button for each grid col.-}
social_platform : Model -> Html Msg
social_platform model = Grid.container [style "background-color" "#666262"]
    [Grid.row [Row.rightMd]
            [ Grid.col [] []
            , Grid.col [ Col.xs6 ] []
            , Grid.col []
            [ButtonGroup.toolbar []
                                         [
                                         ButtonGroup.linkButtonGroupItem []
                                             [ ButtonGroup.linkButton
                                              [Button.attrs
                                                  [href "https://www.tiktok.com/@farsawir"
                                                  ]
                                                  ,
                                                  Button.small
                                              ]
                                              [Html.img [src "./resources/images/tick_tok_icon.png"  ]
                                                  [
                                                  ]
                                              ]
                                              , ButtonGroup.linkButton
                                              [Button.attrs
                                                  [href "https://www.youtube.com/channel/UC_GxA_40R305OZkr2o5ka3A/featured"
                                                  ]
                                                  ,
                                                  Button.small
                                              ]
                                              [Html.img [src "./resources/images/youtube_icon.png" ]
                                                 [
                                                 ]
                                              ]
                                              , ButtonGroup.linkButton
                                              [Button.attrs
                                                 [href "https://github.com/KDahir247"
                                                 ],
                                                 Button.small
                                              ]
                                              [Html.img [src "./resources/images/github_icon.png"  ]
                                                  [
                                                  ]
                                              ]

                                             ]
                                         ]
            ]

            ]
    ]


pageHome : Model -> Html msg
pageHome  model = Grid.container [Html.Attributes.style "padding-top" "50px"]
    <|
    [Grid.row []
        [ Grid.col [Col.xs9, Col.md8]
        [
        Card.config [Card.align Text.alignXsCenter]
        |> Card.block []
        [
        {-Card detail here-}
          Block.titleH3 [] [Html.text "Hello World"]
        , Block.text[] [Html.text "first blog post"]
        , Block.custom
         <| Button.button[Button.primary] [Html.text "read"]
        ]
        |> Card.view

        ]
        , Grid.col [] [Html.text "grid"]

        ]
    ]
    
                            
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
        case msg of
            NavbarMsg state ->
                ( { model | navState = state }, Cmd.none )
            ClickedLink (Browser.External "") ->
                (model, Cmd.none)
            ClickedLink (Browser.External url) ->
                (model, Browser.Navigation.load url)
            _ ->
                (model, Cmd.none)




subscription model =
        Navbar.subscriptions model.navState NavbarMsg

main = Browser.application
    {init = init
    ,view = view
    , update = update
    , subscriptions = subscription
    , onUrlChange = UrlChanged
    , onUrlRequest = ClickedLink
    }