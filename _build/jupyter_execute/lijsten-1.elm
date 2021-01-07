# Lijsten (1)

## Lijst : reeks waarden van eenzelfde type

opsommen:

```
firstprimes = [3,5,7,11]
cities = ["Rotterdam", "Den Haag", "Utrecht", "Eindhoven"]
multiples = [[2,4,8], [3,9,27], [4,16,64]]
emptylist = []
singleton = [3]
```

plaats element op kop van lijst (cons):  `"Amsterdam" :: cities`

`[3,5,7,11] == 3 :: 5 :: 7 :: 11 :: []`

## Genereren van lijsten

Enkele functies voor het genereren van lijsten:

`range lo hi`: genereert de lijst `[lo, lo+1, ..., hi]`.

`repeat n x` : genereert de lijst `[x, x, ..., x]` van lengte n.

```elm
  range 2 4 == [2,3,4]
  range 4 2 == []

  repeat 3 "noot" == ["noot", "noot", "noot"]
```

*  `++` : append (samenstellen)
* `reverse` : omkeren van een lijst
* `length` : lengte van een lijst
* `member` : test of een element in de lijst voorkomt

```elm
morecities = cities ++ ["Groningen", "Leeuwarden", "Assen"]
moreprimes = firstprimes ++ [13,17,19,23,29]

  reverse [3,5,7,11] == [11,7,5,3]
  length [3,5,7,11] == 4
  member 4 [3,5,7,11] == False
```

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

## map, foldr/foldl, filter

* `map f lst` - voert functie f uit op alle elementen in lst 
* `map sqr [3,5,7] == [sqr 3, sqr 5, sqr 7]`
* `map double [3,5] == [double 3, double 5] == [6,10]`

`foldr f e lst` - voert functie f uit *tussen* alle elementen in `e::lst`.

```elm
  foldr (+) 0 [3,5,7] == 3 + (5 + (7 + 0)) == 15
  foldr (*) 1 [3,5,7] == 3 * (5 * (7 * 1)) == 105
```

* `(+) 3 4 == 3 + 4` - "+" is een functie
* `e` is *eenheidselement*:  0 voor +, 1 voor *
* `foldr` *reduceert* een lijst naar een enkele waarde.
* `foldr` reduceert "van rechts naar links" (zie de haakjes), 
* `foldl` reduceert "van links naar rechts".

`filter f lst` - alleen die elementen uit `lst` waarvoor `f` `True` oplevert.

```elm
  filter isEven [1,2,3,4,5] == [2,4]
  filter isOdd [1,2,3,4,5] == [1,3,5]
```

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

`map`, `foldr` en `filter`: voorbeelden van *functies als parameter*.

```elm
map : (a -> b) -> List a -> List b
map      f         lst    = ...

foldr : (a -> b -> b) -> b -> List a -> List b
foldr       f            e     lst    = ...

filter : (a -> Bool) -> List a -> List a
filter       f           lst    = ...
```



`map`, `foldr` en `filter`: veel-voorkomende rekenpatronen,
geparametriseerd met de eigenlijke berekening (functie).

`map`, `foldr` en `filter` zijn normale Elm-functies:
deze kun je ook zelf definiëren.

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