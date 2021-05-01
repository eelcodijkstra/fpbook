import Html exposing (div, h3, p, text)
import Html.Attributes exposing (style)

main =
  div [style "color" "red"]
    [ h3 [style "color" "blue"] [ text "Kopje"]
    , p  []  [ text "Tekst tekst tekst" ]
    ] 

-- compile-code

import Html exposing (div, ul, li, text)
import Html.Attributes exposing (style)
import List exposing (map)

bulletlist attrs lst =
  ul attrs (map (\elt -> li [] [text elt]) lst)

main =
  div []
  [ bulletlist [] ["aap", "noot", "mies"]
  , bulletlist [style "color" "blue"] ["wim", "zus", "jet"]  
  ]
  
-- compile-code
