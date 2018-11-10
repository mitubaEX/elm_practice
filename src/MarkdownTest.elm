import Browser
import Html exposing (Html, Attribute, div, textarea, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Markdown


flex = style "display" "flex"

-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { content : String
  }


init : Model
init =
  { content = "" }



-- UPDATE


type Msg
  = Change String | Share


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }
    Share -> { model | content = String.append model.content "1" }



-- VIEW


view : Model -> Html Msg
view model =
  div [ flex ]
    [ textarea [ placeholder "Text to reverse", value model.content, onInput Change, style "margin" "15px" ] []
    , div [] [ Markdown.toHtml [] (model.content) ]
    , div [] [
        button [ onClick Share ] [ text "Share" ]
        ]
    ]
