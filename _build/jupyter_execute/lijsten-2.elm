# Lijsten (2)

In dit hoofdstuk behandelen we functies op lijsten, bijvoorbeeld voor het optellen van alle elementen in een lijst.
In zo'n functie gebruiken we de manier waarop een lijst opgebouwd is:  `[a, b, c] == a :: [b, c]`

Een lijst is ofwel `[]` (de lege lijst), ofwel van de vorm `x :: xs` ("x op kop van de lijst xa").

> Een niet-lege lijst bestaat uit een kop-element en een staart-lijst; dit noemen we wel een *recursieve* structuur, omdat dezelfde lijst-vorm in de lijst weer terugkomt. Een ander voorbeeld van een recursieve structuur is een *boom*: een boom is ofwel leeg, ofwel een knoop met een waarde, en een aantal subbomen.

Een lijst-functie volgt de opbouw van de lijst

```elm
  f lst =
    case lst of
      (x :: xs) ->
         ... compute for x and xs...
      []
         ... compute for []
```

We gebruiken hier de `case x of ...`-expressie, waarin de verschillende vormen van de waarde `x` onderscheiden worden.

Als eerste voorbeeld bekijken we een functie voor het sommeren van alle elementen in een lijst:

```elm
sum : List Int -> Int
sum lst =
  case lst of
    (x :: xs) ->
      x + sum xs
     
    [] ->
      0
```

We kunnen `sum [3,5]` met de hand uitwerken, op dezelfde manier als we eerder voor de simpele functies gedaan hebben:

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

Merk op:

* de specificatie (betekenis) van `sum lst` is dat deze de som van de elementen van `lst` oplevert.
* via de `case` splitsen we de lijst `lst` in de kop `x` en de staart `xs`.
* de lijst `xs` is (1) korter dan de lijst `lst.
* in de functie `sum` nemen we aan dat de functie `sum` voor de (kortere) lijst `xs` het gespecificeerde resultaat oplevert.

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

