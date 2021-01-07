# Lijsten (2)

Opbouw van een lijst: `[a, b, c] == a :: [b, c]`

Lijst is of `[]` , of van de vorm `x :: xs` (*recursieve structuur*)


Lijst-functie volgt opbouw van de lijst

```elm
  f lst =
    case lst of
      (x :: xs) ->
         ... compute for x and xs...
      []
         ... compute for []
```         

Sommeren van alle elementen in een lijst:

```elm
sum : List Int -> Int
sum lst =
  case lst of
    (x :: xs) ->
      x + (sum xs)
     
    [] ->
      0
```

```elm
    sum [3,5]
=               { def. sum, case }
    case (3 :: [5]) -> 3 + sum [5]
=               { case rule }
    3 + sum [5]
=               {def. sum, case }
    5 + case (5 :: []) -> 5 + sum []
=               { case rule }
    3 + 5 + sum []
=               { def. sum, case }
    3 + 5 + case [] -> 0
=               { case rule }
    3 + 5 + 0
=               { arithmetic }
    8
```

## definitie van map

```elm
map : (a -> b) -> List a -> List b
map f lst =
  case lst of
    (x :: xs) ->
      (f x) :: (map f xs)
      
    [] ->
      []
```      

## definitie van foldr

```elm
foldr : (a -> b -> b) -> b -> List a -> b
foldr f e lst =
  case lst of
    (x :: xs) ->
      f x (foldr f xs)
      
    [] ->
      e
```

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

## Samenvatting

* `map`, `foldr` en `filter` zijn *gewone Elm-functies*
* een lijst-functie volgt de (recursieve) structuur van de lijst

Volgende stap: bomen en functies op bomen.

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

**Opdracht**

* definieer de functie `filter f lst` voor het filteren van een lijst met een Bool-functie.
* demonstreer deze functie in het bovenstaande programma.

**Opdracht**

* definieer de functie `length : (List a) -> Int` voor het bepalen van het aantal elementen in een lijst
    * met behulp van `map`;
    * uitgeschreven, zoals in het `sum`-voorbeeld
* definieer de functie `range : Int -> Int -> List Int` voor het maken van een lijst van opeenvolgende gehele getallen.
* definieer de functie `repeat : Int -> a -> List a` voor het maken van een lijst met identieke elementen.

**Opdracht**

* schrijf de berekening `map sqr [3,5]` uit, met `sqr x = x * x`.
* schrijf de berekening `foldr (+) 0 [3,5]` uit, met `(+) x y = x + y`
* schrijf de berekening `foldr (::) [] [3,5]` uit, met `(::) x xs = x :: xs`.

## Een andere variatie: foldl

`sum [1,2,3]` als ((0 + 1) + 2) + 3 of eigenlijk 3 + (2 + (1 + 0)))


```elm
sum lst =
  sum1 0 lst
  
sum1 acc lst =   -- acc is "accumulator" of partial result
  case lst of
    (x :: xs) ->
      sum1 (x + acc) xs
      
    [] ->
      acc -- final result
```

```
foldl : (a -> b -> b) -> b -> List a -> b 
foldl f acc lst =
  case lst of
    (x :: xs) ->
      foldl f (f x acc) xs
      
    [] ->
      acc
```      

**Opdracht**

* Schrijf de berekening `foldl (+) 0 [3,5]` uit, met `(+) x y = x + y`
* Ga na wat het resultaat is van `foldl (::) [] [3,5]`, met `(::) x xs = x :: xs`
* Schrijf deze berekening uit.

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

