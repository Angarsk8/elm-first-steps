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
view model =
    div []
        [ div []
            [ button [ onClick DecrementCount ] [ text "-" ]
            , text (toString model.count)
            , button [ onClick IncrementCount ] [ text "+" ]
            ]
        , div []
            [ button [ onClick DecrementStep ] [ text "-" ]
            , text (toString model.step ++ "(steps)")
            , button [ onClick IncrementStep ] [ text "+" ]
            ]
        , input [ type_ "number", value (toString model.step), onInput SetStep ] []
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { count, step } =
            model
    in
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
    let
        initialStep =
            initialModel.step
    in
        Result.withDefault initialStep (String.toInt value)
