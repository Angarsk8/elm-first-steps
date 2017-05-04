module Counter exposing (..)

import Html exposing (Html, div, button, input, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)


-- MODEL


type alias Model =
    { count : Int
    , step : Int
    }


initialModel : Model
initialModel =
    { count = 0
    , step = 1
    }



-- MESSAGES


type Msg
    = IncrementCount
    | DecrementCount
    | IncrementStep
    | DecrementStep
    | SetStep String



-- VIEW


view : Model -> Html Msg
view { count, step } =
    div []
        [ div []
            [ button [ onClick DecrementCount ] [ text "-" ]
            , text (toString count)
            , button [ onClick IncrementCount ] [ text "+" ]
            ]
        , div []
            [ button [ onClick DecrementStep ] [ text "-" ]
            , text (toString step ++ "(steps)")
            , button [ onClick IncrementStep ] [ text "+" ]
            ]
        , input [ type_ "number", value (toString step), onInput SetStep ] []
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ count, step } as model) =
    case msg of
        IncrementCount ->
            ( { model | count = count + step }, Cmd.none )

        DecrementCount ->
            ( { model | count = count - step }, Cmd.none )

        IncrementStep ->
            ( { model | step = step + 1 }, Cmd.none )

        DecrementStep ->
            ( { model | step = step - 1 }, Cmd.none )

        SetStep value ->
            ( { model | step = toInt value }, Cmd.none )



-- HELPERS


toInt : String -> Int
toInt value =
    Result.withDefault initialModel.step (String.toInt value)
