module Widget exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    Bool


initialModel : Model
initialModel =
    True



-- MESSAGES


type Msg
    = Collapse
    | Expand



-- VIEW


view : Model -> Html Msg
view model =
    if model then
        button [ onClick Expand ] [ text "Click to expand" ]
    else
        div []
            [ button [ onClick Collapse ] [ text "Click to collapse" ]
            , text "This test is only visible when expanded"
            ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Collapse ->
            ( True, Cmd.none )

        Expand ->
            ( False, Cmd.none )
