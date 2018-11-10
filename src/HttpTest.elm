import Http
import Browser
import Html exposing (Html, Attribute, div, textarea, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Markdown
import Url.Builder as Url
import Json.Decode exposing (Decoder, field, string)


url = "https://www.reddit.com/r/golang/.json"


-- MAIN


main =
  Browser.element
  { init = init
  , update = update
  , subscriptions = subscriptions
  , view = view
  }



-- MODEL


type alias Model =
  { content : String
  }


init : () -> (Model, Cmd Msg)
init _ =
  ({ content = "" }, Cmd.none)



-- UPDATE


type Msg
  = Change (Result Http.Error String) | Share


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Change newContent ->
      case newContent of
        Ok content ->
          ({model | content = content}, Cmd.none)
        Err _ -> ({model | content = ""}, Cmd.none)
    Share -> (model, getExamplePage)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
  [
    div [] [button [ onClick Share ] [ text "Share" ]]
    , div [] [ text (model.content) ]
    ]


getExamplePage: Cmd Msg
getExamplePage = Http.send Change (Http.get url resultDecoder)

resultDecoder: Decoder String
resultDecoder = field "kind" string
