module App exposing (..)

import Html exposing (Html, div)
import Counter
import Widget


-- MODEL


type alias Model =
    { counterModel : Counter.Model
    , widgetModel : Widget.Model
    }


initialModel : Model
initialModel =
    { counterModel = Counter.initialModel
    , widgetModel = Widget.initialModel
    }



-- MESSAGES


type Msg
    = CounterMsg Counter.Msg
    | WidgetMsg Widget.Msg



-- VIEWS


view : Model -> Html Msg
view model =
    div []
        [ Html.map CounterMsg (Counter.view model.counterModel)
        , Html.map WidgetMsg (Widget.view model.widgetModel)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CounterMsg inner ->
            let
                ( updatedCounter, cmd ) =
                    Counter.update inner model.counterModel
            in
                ( { model | counterModel = updatedCounter }, Cmd.map CounterMsg cmd )

        WidgetMsg inner ->
            let
                ( updatedWidget, cmd ) =
                    Widget.update inner model.widgetModel
            in
                ( { model | widgetModel = updatedWidget }, Cmd.map WidgetMsg cmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- APP
--uncomment if needed -- import Html.App as App


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
