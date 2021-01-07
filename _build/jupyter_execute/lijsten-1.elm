# Lijsten (1)

Een lijst is een reeks waarden van hetzelfde type, bijvoorbeeld getallen, strings of lijsten van getallen.

Je kunt de waarden in een lijst opsommen:

```
firstprimes = [3,5,7,11]
cities = ["Amsterdam", "Rotterdam", "Den Haag", "Utrecht", "Eindhoven"]
multiples = [[2,4,8], [3,9,27], [4,16,64]]
emptylist = []
singleton = [3]
```

De basisoperatie voor het maken van een lijst is `::` ("cons", of "op kop van"), waarmee je een element op kop van een lijst plaatst.
De notatie `[3,5,7,11]` is een afkorting voor `3 :: 5 :: 7 :: 11 :: []`

Enkele functies voor het genereren van lijsten:

`range lo hi`: genereert de lijst `[lo, lo+1, ..., hi]`.

`repeat n x` : genereert de lijst `[x, x, ..., x]` van lengte `n`.

```
range 2 4 == [2,3,4]
range 4 2 == []

repeat 3 "noot" == ["noot", "noot", "noot"]
```

**Opdracht**

* Probeer de bovenstaande voorbeelden uit in de Elm repl (via een Terminal-venster)

## Enkele functies op lijsten

Enkele functies op lijsten (uit de Lists-library):

`++` : append (samenstellen), bijvoorbeeld

```
morecities = cities + ["Groningen", "Leeuwarden", "Assen", "Zwolle"]
moreprimes = firstprimes + [13,17,19,23,29]
```

`reverse` : omkeren van een lijst

```
  reverse [3,5,7,11] == [11,7,5,3]
```

`length` : lengte van een lijst

```
  length [3,5,7,11] == 4
```

`member` : test of een element in de lijst voorkomt

```
  member 4 [3,5,7,11] == False
  ```
  
Later in dit hoofdstuk behandelen we de lijst-functies `map`, `foldr`/`foldl`, en `filter`.  
  
Voor meer operaties op lijsten, zie de [Lists library](https://package.elm-lang.org/packages/elm/core/latest/List)

**Opdracht**

Probeer de bovenstaande voorbeelden uit in de Elm repl (via een Terminal-venster).

## Elm - voorbeeld

Het Elm-programma hieronder bevat een aantal voorbeelden van lijst-expressies.
Voor het afdrukken van een lijst als Elm-lijst gebruik je `Debug.toString`.

import Html exposing (div, text, Html)
import List exposing (range, repeat, member, length, reverse)
import Debug exposing (toString)

printList : List a -> Html msg
printList lst =
  div [] [text (Debug.toString lst)]
  
firstprimes = [2,3,5,7,11]  

main =
  div []
  [ printList ( [1,3,5] ++ [7,9] )
  , printList ( 1 :: 3 :: 5 :: 7 ::[] )
  , printList ( range 3 7 )
  , printList ( repeat 4 "hi")
  , printList ( repeat 4 ["hi", "world"])
  , text (Debug.toString (member 5 firstprimes))
  ]
  
-- compile-code

**Opdracht**

* breid bovenstaand programma uit met een aantal voorbeelden waarin je de lijst-functies gebruikt.
* definieer een functie `palindroom` die `True` oplevert als de lijst een palindroom is, en anders `False`. (*Hint*: gebruik de definitie van palindroom)

    * test dit uit in de Elm repl, in een Terminal-venster.
    * in Elm is een String geen List, dus je functie werkt niet zonder meer op String-waarden.


## map, fold(r/l), filter

Voor het werken met lijsten zijn de functies `map`, `foldr`/`foldl` en `filter` erg handig.
Deze functies kom je (als map/reduce) in veel andere programmeertalen en -omgevingen tegen.
De eerste parameter van deze functies is steeds een *functie* die uitgevoerd wordt op of tussen de elementen van de lijst. Dit is een voorbeeld van een *functie als parameter*.

* `map` - voert een functie uit op alle elementen in een lijst
    * `map f [3,5,7] == [f 3, f 5, f 7]`
    * `map double [3,5,7] == [double 3, double 5, double 7] == [6,10,14]`
* `foldr` - voert een functie uit *tussen* alle elementen in een lijst voorafgegaan door het "eenheidselement".
    * `foldr (+) 0 [3,5,7] == 0 + (3 + (5 + 7)) == 15`
    * voor optelling is 0 het eenheidselement
    * `folrd` werkt "van rechts naar links" (zie de haakjes hierboven), `foldl` "van links naar rechts".
    * `foldr` en `foldl` *reduceren* een lijst naar een enkele waarde.
* `filter` - houdt alleen die elementen over waarvoor de boolean functie `True` oplevert.
    * `filter iseven [1,2,3,4,5] == [2,4]`

In het Elm-programma hieronder definiëren we de hulpfuncties `printList`, `printBool` en `printInt`, om deze waarden in een HTML-element weer te geven. 

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
  
double : Int -> Int
double x = 
  x + x
  
iseven : Int -> Bool
iseven x =
  modBy 2 x == 0 -- even: rest na deling door 2 is 0
  
firstprimes = [2,3,5,7,11]

main =
  div []
  [ printList ( firstprimes )
  , printList ( map double firstprimes )
  , printList ( range 1 10 )
  , printList ( map iseven (range 1 10) )
  , printList ( filter iseven (range 1 10) )
  , printInt  ( foldr (+) 0 (repeat 10 1) )
  , printInt  ( foldr (+) 0 (range 1 10) )
  ]
  
-- compile-code

**Opdrachten**

* maak een functie `mod100 x` die de rest oplevert van de deling `100 // x`.
* gebruik deze functie om de rest van `100 // x` te bepalen, voor de priemgetallen in `firstprimes`.
* gebruik `foldr` om alle elementen in een lijst met elkaar te vermenigvuldigen. Hint: wat is de initiële waarde bij vermenigvuldiging?
* gebruik `map` om een lijst te maken waarin alle elementen met 1 opgehoogd zijn.

import Html exposing (..)
import String exposing (fromInt)
import Debug exposing(..)

sum lst =
  case lst of
    []       -> 0
    x :: xs -> x + sum xs

print str =
  div [] [text str]

double x = x + x

smallprimes = [3,5,7,11]
doubleprimes = List.map double smallprimes

main =
  div []
  [ print "aap"
  , print (Debug.toString ([1,3,5] ++ [7,11]))
  , print (Debug.toString (1 :: 3 :: 5 :: 7 ::[]))
  , print (Debug.toString smallprimes)
  , print (Debug.toString doubleprimes)
  , print (Debug.toString (List.foldr (+) 0 smallprimes))
  ]
  
-- compile-code

** Opdracht **

* gebruik `foldr` om alle elementen in een lijst met elkaar te vermenigvuldigen. Hint: wat is de initiële waarde bij vermenigvuldiging?
* gebruik `map` om alle elementen in een lijst 1 op te hogen


## Functie als resultaat

```
add x y = x + y
succ x = add 1
```

NB: de notatie van het type helpt hier om duidelijk te maken wat er aan de hand is.

## Functie als parameter

* map
* 

## Anonieme functies (lambda-expressies)

```
sqr = \x -> x * x  -- in plaats van sqr x = x * x
```

Vooral nuttig als (bijv.) parameter van `map`; in het algemeen, functie als parameter.


## Andere lijstoperaties

* zip (resultaat: lijst van tuples)
* vb: optellen van de elementen van twee lijsten
* genereren van een lijst getallen?

import Html exposing (..)
import String exposing (fromInt)
import Debug exposing(..)
import List exposing(..)

sum lst =
  case lst of
    []       -> 0
    x :: xs -> x + sum xs

print str =
  div [] [text str]

double x = x + x

smallprimes = [3,5,7,11]
doubleprimes = List.map double smallprimes

zip a b = List.map2 (\x y -> (x, y)) a b

plus (x, y) = x + y

main =
  div []
  [ print "aap"
  , print (Debug.toString ([1,3,5] ++ [7,11]))
  , print (Debug.toString (1 :: 3 :: 5 :: 7 ::[]))
  , print (Debug.toString smallprimes)
  , print (Debug.toString doubleprimes)
  , print (Debug.toString (List.foldr (+) 0 smallprimes))
  , print (Debug.toString (List.map plus (zip smallprimes (List.reverse smallprimes))))
  ]
  
-- compile-code

## Elm en HTML

Elm is in de eerste plaats bedoeld voor het maken van interactieve webpagina's, als alternatief voor JavaScript.

Het volgende programma demonstreert hoe je een stukje HTML maakt met Elm. Hiervoor gebruik je de functies uit de Html-library. Elke functie heeft de rol van een HTML-tag, met 2 lijsten als parameter: de lijst met attributen, en de lijst met HTML-elementen binnen de tag.

Voorbeeld:

```
  <div style="color: red;">
    <h3 style="color: blue;"> Kopje </h3>
    <p> Tekst tekst tekst </p>
  </div> 
```

schijf je in Elm als:

```
  div [style "color" "red"]
    [ h3 [style "color" "blue"] [ text "Kopje"]
    , p  []  [ text "Tekst tekst tekst" ]
    ]       
```

import Html exposing (..)
import Html.Attributes exposing (..)

main =
  div [style "color" "red"]
    [ h3 [style "color" "blue"] [ text "Kopje"]
    , p  []  [ text "Tekst tekst tekst" ]
    ] 

-- compile-code

Eén van de voordelen van het gebruik van *functies* voor het maken HTML-code is dat je deze functis als abstractie-mechanisme kunt gebruiken: je hoeft jezelf niet te herhalen (DRY), je kunt altijd een functie maken voor een patroon dat vaker voorkomt.

> Waarom functies? Functies vormen een belangrijk en universeel abstractie-mechanisme, niet alleen voor algoritmen, maar bijvoorbeeld ook voor veel-voorkomende patronen in "besturingsstructuren". Denk bijv. aan map en reduce (foldr).

In het volgende voorbeeld maken we een functie `bulletlist` waarmee we een reeks (lijst) strings voorstellen als een "bullet list" (HTML: `<ul>`).

> Een meer algemene oplossing is om in plaats van strings, Html-elementen toe te staan. Bovendien zou je `bulletlist` kunnen voorzien van een attributen-lijst: je kun `bulletlist` gebruiken als een eigen HTML-tag. Dit laten we als oefening voor de lezer. 

import Html exposing (div, ul, li, text)
import List exposing (map)

bulletlist attrs lst =
  ul attrs (map (\elt -> li [] [text elt]) lst)

main =
  div []
  [ bulletlist [style "color" "red"] ["aap", "noot", "mies"]
  , bulletlist [] ["wim", "zus", "jet"]  
  ]
  
-- compile-code

import Html exposing (div, ul, li, text)
import List exposing (map)

bulletlist attrs elts =
  ul attrs (map (\elt -> li [] [text elt]) elts)

main =
  div []
  [ bulletlist [] ["aap", "noot", "mies"]
  , bulletlist [] ["wim", "zus", "jet"]  
  ]
  
-- compile-code

import Html exposing (..)
import String exposing (fromInt)
import Debug exposing(..)
import List exposing(..)

sum lst =
  case lst of
    []       -> 0
    x :: xs -> x + sum xs

print str =
  div [] [text str]

double x = x + x

smallprimes = [3,5,7,11]
doubleprimes = List.map double smallprimes

zip a b = List.map2 (\x y -> (x, y)) a b

plus (x, y) = x + y

main =
  div []
  [ ul []
      [ li [] [text "aap"]
      , li [] [text "noot"]
      , li [] [text "mies"]
      ]
  ]
  
-- compile-code

Dit patroon kun je in de vorm van een functie gieten, met een lijst van strings (of van Html-elementen)

* tabel als functie, met lijsten (van lijsten) als parameter.
* 

Gebruik van `case` voor *ontrafelen* van lijst-parameter, volgens de structuur van de lijst.

```
sum lst =
  case lst of
    []       -> 0
    x :: xs  -> x + sum xs
```

import Html exposing (..)
import String exposing (fromInt)

sum lst =
  case lst of
    []       -> 0
    x :: xs -> x + sum xs

main =
  text ("sum [3, 5, 7, 11] = " ++ fromInt (sum [3, 5, 7, 11]))
  
-- compile-code

```
  sum [3, 5]
  
=                 { def. sum }

  case [3, 5] of
    []         -> 0
    3 :: [5]   -> 3 + sum [5]
    
=                 { def. case }

  3 + sum [5]
  
=                 { def. sum }

  3 + (case [5] of
        []      -> 0
        5 :: [] -> 5 + sum [])
        
=                 { def. case }

  3 + (5 + sum [])
  
=                 { def. sum }

  3 + (5 + (case [] of
             []   -> 0
             _    -> _ )
             
=                 { def. case }

  3 + (5 + (0))
  
=                 { rekenen }

  8
```

*Opmerking.* In de volgende voorbeelden combineren we meestal de stappen van "def. function" en "def. case".

*Opmerking.* De som van de lijst wordt hier van rechts naar links uitgerekend; in het geval van `sum [3,5,7,11]` krijgen we bijvoorbeeld `3 + (5 + (7 + (11 + (0))))`. Dit rekenpatroon noemen we wel een "right fold". Dit patroon kun je ook in een functie gieten, zie `foldr`.

Dit is een voorbeeld van de manier waarop je met functies kunt rekenen (en waarop je met functies kunt redeneren?)

**Opdracht.** Maak een functie `prod lst` voor het vermenigvuldigen van alle elementen in een lijst. Je mag ervan uitgaan dat de lijst tenminste 1 element heeft (?) OF: het resultaat voor de lege lijst is 1 (`prod [] = 1`).

**Opmerkingen en vragen**


Ingebouwde functies voor lijsten

Zie: https://package.elm-lang.org/packages/elm/core/latest/List

Veel van de functies op lijsten kun je gebruiken zonder zelf een lijst-deconstructie met een `case` te doen. Veel voorkomende functies zijn bijv. `map` en `reduce`. (`foldl` en `foldr`)

import Html exposing (..)
import String exposing (fromInt)
import Debug exposing(..)

sum lst =
  case lst of
    []       -> 0
    x :: xs -> x + sum xs

main =
  -- text (String.concat (List.map fromInt [3,5,7]))
  -- text (Debug.toString ["aap","noot","mies"])
  
-- compile-code

Opmerkingen

* in Elm is een String geen List!
* voor het afdrukken van een List-waarde gebruik je Debug.toString. Er is geen andere "print" functie. (In de praktijk druk je Lists nauwelijks af; je gebruikt dat als waarde om mee te rekenen.)
* `Html.map` zit ons regelmatig dwars.
* Elm heeft geen `zip`-functie, wel een `unzip`. (Overigens kun je `zip` gemakkelijk zelf maken, maar waarom niet in de standaard-library???)

Notatie van lijst-waarden ("Literals")

```
[]             -- de lege lijst
[3]            -- lijst met 1 element, "singleton"
[3,5,7,11,13]  -- lijst met 5 elementen, "lengte is 5"

3::[]          -- 3 op kop van de lege lijst: [3]
3::[5,7,11,13] -- 3 op kop van [5,7,11,13]: [3,5,7,11,13]
3::5::7::11::13::[] -- [3,5,7,11,13]
```

import Html exposing (..)
import String exposing (fromInt)
import Debug exposing(..)

sum lst =
  case lst of
    []       -> 0
    x :: xs -> x + sum xs

print str =
  div [] [text str]

double x = x + x

smallprimes = [3,5,7,11]
doubleprimes = List.map double smallprimes

main =
  div []
  [ print "aap"
  , print (Debug.toString ([1,3,5] ++ [7,11]))
  , print (Debug.toString (1 :: 3 :: 5 :: 7 ::[]))
  , print (Debug.toString smallprimes)
  , print (Debug.toString doubleprimes)
  , print (Debug.toString (List.foldr (+) 0 smallprimes))
  ]
  
-- compile-code