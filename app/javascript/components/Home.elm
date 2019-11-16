module Home exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (id, class)
import Http
import Json.Decode as Decode exposing (Decoder, string, int)
import Json.Decode.Pipeline exposing (required)
import Time
import DateFormat

type alias Log =
  { timestamp : Int
  , user : String
  , message : String
  }
type alias Logs = List Log

type Model
  = Failure
  | Loading
  | Success Logs


-- MAIN

main =
  Browser.element { init = init, update = update, subscriptions = subscriptions, view = view }

-- MODEL

init : () -> (Model, Cmd Msg)
init _ =
  (Loading, getLogs)


-- UPDATE

type Msg
  = GotLogs (Result Http.Error Logs)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotLogs result ->
      case result of
        Ok logs ->
          (Success logs, Cmd.none)

        Err err ->
          (Failure, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW

view : Model -> Html Msg
view model =
  case model of
    Loading ->
      h3 [] [ text "Loading..." ]

    Failure ->
      h3 [] [ text "getting logs failed spectacularly" ]

    Success logs ->
      div [ id "logs_container" ] (List.map formatLog (List.reverse logs))

formatLog : Log -> Html Msg
formatLog log =
  div [ class "log-container" ]
    [ div [ class "timestamp inline" ] [ formatDate log.timestamp ]
    , div [ class "timestamp-separator" ] []
    , div [ class "user inline" ] [ text log.user ]
    , div [ class "user-separator" ] [ text ":" ]
    , div [ class "message" ] [ text log.message ]
    ]

dateFormatter : Time.Zone -> Time.Posix -> String
dateFormatter =
  DateFormat.format
    [ DateFormat.hourMilitaryFixed
    , DateFormat.text ":"
    , DateFormat.minuteFixed
    , DateFormat.text ":"
    , DateFormat.secondFixed
    ]

formatDate : Int -> Html Msg
formatDate timestamp =
  text (dateFormatter Time.utc (Time.millisToPosix timestamp))


-- HTTP

getLogs : Cmd Msg
getLogs =
  Http.get
  { url = "/logs.json"
  , expect = Http.expectJson GotLogs decodeLogs
  }

decodeLogs : Decoder Logs
decodeLogs =
  Decode.list logDecoder

logDecoder : Decoder Log
logDecoder =
  Decode.succeed Log
      |> required "sent_at" int
      |> required "user" string
      |> required "message" string

