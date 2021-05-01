import Html exposing (div, p, text)
import Html.Attributes exposing (style)

main =
  div [style "color" "blue"]
    [  p  []  [ text "Dit is de uitvoer van een Elm programma" ]
    ] 

-- compile-code

import Html exposing (div, p, text)
import String

main =
   p  []  [ text ("2 + 3 = " ++ (String.fromInt( 2 + 3 )))]

-- compile-code

import Html exposing (div, p, text)
import Html.Attributes exposing (style)
import String

main =
  div [style "color" "blue"]
    [  p  []  [ text ("2 + 3 = " ++ (String.fromInt(2 + 3)))]
    ] 

-- compile-code


