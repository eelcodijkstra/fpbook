import Html exposing (div, text, Html)
import List exposing (range, repeat, member, length, reverse)
import Debug exposing (toString)

printList lst = div [] [text (Debug.toString lst)]
  
firstprimes = [2,3,5,7,11]  

main =
  div []
  [ printList ( [1,3,5] ++ [7,9] )
  , printList ( 1 :: 3 :: 5 :: 7 ::[] )
  , printList ( reverse (range 3 7) ) 
  , printList ( repeat 4 ["hi", "world"])
  , text (Debug.toString (member 5 firstprimes))
  ] 
-- compile-code

import Html exposing (div, text, Html)
import List exposing (range, repeat, member, length, reverse, map, foldr, foldl, filter)
import Debug exposing (toString)

printList : List a -> Html msg
printList lst =
  div [] [text (Debug.toString lst)]
  
printBool : Bool -> Html msg
printBool b =
  div [] [text (Debug.toString b)]
  
printInt : Int -> Html msg
printInt x =
  div [] [text (Debug.toString x)]  
  

double x = x + x
isEven x = modBy 2 x == 0 -- even: rest na deling door 2 is 0
firstprimes = [2,3,5,7,11]

main =
  div [] 
  [ printList ( map double firstprimes )
  , printList ( map isEven (range 1 10) )
  , printList ( filter isEven (range 1 10) )
  , printInt  ( foldr (+) 0 (repeat 10 3) )
  , printInt  ( foldr (*) 1 (range 1 10) )
  ]
-- compile-code

import Html exposing (div, text, Html)
import List exposing (range, repeat, member, length, reverse, map, foldr, foldl, filter)
import Debug exposing (toString)

printList : List a -> Html msg
printList lst =
  div [] [text (Debug.toString lst)]
  
printBool : Bool -> Html msg
printBool b =
  div [] [text (Debug.toString b)]
  
printInt : Int -> Html msg
printInt x =
  div [] [text (Debug.toString x)]  
  

double x = x + x
isEven x = modBy 2 x == 0 -- even: rest na deling door 2 is 0
firstprimes = [2,3,5,7,11]

main =
  div [] 
  [ printList ( map double firstprimes )
  , printList ( map isEven (range 1 10) )
  , printList ( filter isEven (range 1 10) )
  , printInt  ( foldr (+) 0 (repeat 10 3) )
  , printInt  ( foldr (*) 1 (range 1 10) )
  ]
-- compile-code
