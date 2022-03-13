module Main exposing (..)

import Browser
import Browser.Navigation as Navigation
import Element exposing (..)
import Html exposing (Html, div)
import Html.Attributes exposing (href)
import Url exposing (Url)
import Platform.Cmd
import Bootstrap.Navbar as Navbar

type alias Flags =
    {}

background_color : Color
background_color = Element.rgb 0.1686 0.1686 0.1686

type Msg =
     ClickedLink Browser.UrlRequest
    | UrlChanged Url.Url
    | NavbarMsg Navbar.State


type alias Model =
    { navKey : Navigation.Key
    , navState : Navbar.State
    }

init : Flags -> Url -> Navigation.Key -> (Model, Cmd Msg)
init flag url navKey =
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
        ]
            [
                menu model
            ]
        ]
    }

menu : Model -> Html Msg
menu model = Navbar.config NavbarMsg
    |>  Navbar.withAnimation
    |> Navbar.container
    |> Navbar.brand [href "#"] [Html.text "Fabled Blog"]
    |> Navbar.items
        [ Navbar.itemLink [href "#"] [Html.text "Game Engine"] {-We want to have a group to represent different parts-}
        , Navbar.itemLink [href "#"] [Html.text "Compiler/Interpreter"]
        , Navbar.itemLink [href "#"] [Html.text "Showcase"]
        , Navbar.itemLink [href "#"] [Html.text "About Me"]
        ]
    |> Navbar.view model.navState

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
        case msg of
            NavbarMsg state ->
                ( { model | navState = state }, Cmd.none )

            _ -> (model, Cmd.none)




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