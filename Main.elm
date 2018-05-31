import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)

type alias Model =
  { email : String
  , message : String
  , submitting : Bool
  }

initialModel : Model
initialModel =
  { email = ""
  , message = ""
  , submitting = False
  }

type Msg
  = InputEmail String
  | InputMessage String
  | Submit

main : Program Never Model Msg
main =
  program
    { init = (initialModel, Cmd.none)
    , update = update
    , subscriptions = \model -> Sub.none
    , view = view
    }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    InputEmail e ->
      ({model | email = e}, Cmd.none)
    InputMessage m ->
      ({model | message = m}, Cmd.none)
    Submit ->
      ({model | submitting = True}, Cmd.none)

view : Model -> Html Msg
view model =
  Html.form
    [ onSubmit Submit ]
    [ header
    , body
    , footer
    , div [] [model |> toString |> text]
    ]

header = div []
  [ h1 [] [ text "Feedback Form" ] ]

body = div []
  [ div []
    [ input
      [ placeholder "E-Mail"
      , type_ "email"
      , onInput InputEmail
      , required True
      ] [] ]
  , div []
    [ textarea
      [ placeholder "Message"
      , rows 7
      , onInput InputMessage
      , required True
      ] [] ]
  ]

footer = div []
  [ button
    [ type_ "submit" ]
    [ text "Submit" ]
  , button
    [ type_ "button" ]
    [ text "Cancel" ]
  ]
