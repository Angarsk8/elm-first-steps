module App exposing (..)

import Html exposing (Html, div, program)
import Counter
import Widget


-- MODEL


type alias Model =
    { counter : Counter.Model
    , widget : Widget.Model
    }


initialModel : Model
initialModel =
    { counter = Counter.initialModel
    , widget = Widget.initialModel
    }



-- MESSAGES


type Msg
    = CounterMsg Counter.Msg
    | WidgetMsg Widget.Msg



-- VIEWS


view : Model -> Html Msg
view { counter, widget } =
    div []
        [ Html.map CounterMsg (Counter.view counter)
        , Html.map WidgetMsg (Widget.view widget)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ counter, widget } as model) =
    case msg of
        CounterMsg inner ->
            let
                ( updatedCounter, cmd ) =
                    Counter.update inner counter
            in
                ( { model | counter = updatedCounter }, Cmd.map CounterMsg cmd )

        WidgetMsg inner ->
            let
                ( updatedWidget, cmd ) =
                    Widget.update inner widget
            in
                ( { model | widget = updatedWidget }, Cmd.map WidgetMsg cmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- APP


main : Program Never Model Msg
main =
    program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
