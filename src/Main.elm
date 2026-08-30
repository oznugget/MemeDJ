port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- PORTS

port playSound : String -> Cmd msg


-- MODEL

type alias Sound =
    { label : String
    , emoji : String
    , file : String
    }


sounds : List Sound
sounds =
    [ { label = "fahhh", emoji = "😤", file = "fahhh.mp3" }
    , { label = "sad violin", emoji = "🎻", file = "sad_violin.mp3" }
    , { label = "crickets", emoji = "🦗", file = "crickets.mp3" }
    , { label = "romance", emoji = "💕", file = "romance.mp3" }
    , { label = "dundunduuun", emoji = "🥁", file = "dundunduuun.mp3" }
    , { label = "daddys home", emoji = "👨‍👦", file = "daddys_home.mp3" }
    , { label = "heavenly", emoji = "😇", file = "heavenly.mp3" }
    , { label = "aww", emoji = "🥺", file = "aww.mp3" }
    , { label = "wilhelm scream", emoji = "😱", file = "wilhelm_scream.mp3" }
    , { label = "brother ew", emoji = "🤢", file = "brother_ew.mp3" }
    , { label = "gunshots", emoji = "💥", file = "gunshots.mp3" }
    , { label = "celebration", emoji = "🎉", file = "celebration.mp3" }
    , { label = "oh hell no", emoji = "🙅", file = "oh_hell_no.mp3" }
    , { label = "oh brother this", emoji = "👉", file = "oh_brother.mp3" }
    ]


type alias Model =
    { playing : Maybe String }


type Msg
    = ClickSound String


init : () -> ( Model, Cmd Msg )
init _ =
    ( { playing = Nothing }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickSound file ->
            ( { model | playing = Just file }, playSound file )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hi Shumi" ]
        , div [ class "subhead" ] [ text "🎧 Tap a button to drop the meme" ]
        , div [ class "grid" ]
            (List.map (soundButton model.playing) sounds)
        ]


soundButton : Maybe String -> Sound -> Html Msg
soundButton currentlyPlaying sound =
    let
        isPlaying =
            currentlyPlaying == Just sound.file

        btnClass =
            if isPlaying then
                "sound-btn playing"

            else
                "sound-btn"
    in
    button
        [ class btnClass
        , onClick (ClickSound sound.file)
        , disabled False
        ]
        [ div [ class "emoji" ] [ text sound.emoji ]
        , div [ class "label" ] [ text sound.label ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }