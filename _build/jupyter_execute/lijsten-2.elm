import Html exposing (div, text, Html)
import List exposing (range, repeat, member, length, reverse, filter)
import Debug exposing (toString)
  
printInt : Int -> Html msg
printInt x =
  div [] [text (Debug.toString x)]  

-- own functions

sum : List Int -> Int
sum lst =
  case lst of
    (x :: xs) ->
      x + sum xs

    [] ->
      0

main =
  div [] 
  [ printInt ( sum [3,5,7] )
  , printInt ( sum (range 1 100))
  ]
-- compile-code


