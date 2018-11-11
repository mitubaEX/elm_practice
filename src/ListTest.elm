import Browser
import Html exposing (Html, Attribute, div, text, button, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Markdown


-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { inputText: String, content : List String
  }


init : Model
init =
  { inputText = "", content = [] }



-- UPDATE


type Msg
  = Change String | Add


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newInput ->
      { model | inputText = newInput }
    Add -> { model | content = model.inputText :: model.content, inputText = "" }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [
    input [ placeholder "your input", value model.inputText, onInput Change, style "margin" "15px" ] []
    , div [] [ button [ onClick Add ] [ text "Add" ] ]
    , div [] (List.map (elm) model.content)
    ]


elm : String -> Html Msg
elm a = div [] [text a]
