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




