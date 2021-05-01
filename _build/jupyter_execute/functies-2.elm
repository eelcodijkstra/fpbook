import Html exposing (div, text, Html)
import List exposing (range, repeat, member, length, reverse, filter)
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

map : (a -> b) -> List a -> List b
map      f        lst     =
  case lst of
    (x :: xs) ->
      (f x) :: (map f xs)

    [] ->
      []

foldr : (a -> b -> b) -> b -> List a -> b
foldr        f           e    lst     =
  case lst of
    (x :: xs) ->
      f x (foldr f e xs)

    [] ->
      e 

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
import List exposing (range, repeat, member, length, reverse, filter)
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

map : (a -> b) -> List a -> List b
map f lst =
  case lst of
    (x :: xs) ->
      (f x) :: (map f xs)

    [] ->
      []

foldr : (a -> b -> b) -> b -> List a -> b
foldr f e lst =
  case lst of
    (x :: xs) ->
      f x (foldr f e xs)

    [] ->
      e 

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
import List exposing (range, repeat, member, length, reverse, filter)
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

map : (a -> b) -> List a -> List b
map f lst =
  case lst of
    (x :: xs) ->
      (f x) :: (map f xs)

    [] ->
      []

foldr : (a -> b -> b) -> b -> List a -> b
foldr f e lst =
  case lst of
    (x :: xs) ->
      f x (foldr f e xs)

    [] ->
      e
  
foldl : (a -> b -> b) -> b -> List a -> b  
foldl f acc lst =
  case lst of
    (x :: xs) ->
      foldl f (f x acc) xs
      
    [] ->
      acc

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
  , printInt  ( foldl (*) 1 (range 1 10) )
  , printList ( foldr (::) [] ["a","b","c"] )
  , printList ( foldl (::) [] ["a","b","c"] )  
  ]
-- compile-code



isEven : Int -> Bool
isEven x = modBy 2 x == 0

isOdd : Int -> Bool
isOdd = not << isEven

evens = List.filter isEven (List.range 1 10)
odds = List.filter isOdd (List.range 1 10)
