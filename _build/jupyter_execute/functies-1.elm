# Functies

## Functie-definitie

Functie-definities:

```elm
double x = x + x

max x y = if x >= y then x else y

succ x = x + 1
```

* gelijkheid: links door rechts vervangen (of omgekeerd)
* notatie: geen haakjes

Functie-aanroepen:

```elm
double 3

max 3 4

succ (double 4)

max (double 4) (succ 9)
```

Aanroep: `f x` (opeenvolging) in plaats van `f(x)`

## Rekenen met functies

```
    double (double 3)
=                 { def. double x = x + x }
    double (3 + 3)
=                 { rekenen }
    double 6
=                 { def. double }
    6 + 6
=                 { rekenen }
    12
```

```
    max 3 (double 2)
=              { def. double }
    max 3 (2 + 2)
=              { rekenen }
    max 3 4
=              { def. max }
    if 3 >= 4 then 3 else 4
=              { rekenen }
    if False then 3 else 4
=              { if-regel }
    4
```    

## Typering van functies

```
double: Int -> Int
double x = x + x

max: Int -> Int -> Int
max x y = if x >= y then x else y

```

Niet verplicht, maar wel handig: betere foutmeldingen

## Currying 

```
max: Int -> (Int -> Int)
max x y = if x >= y then x else y
```

Aanroep van max met 1 parameter: levert functie-waarde op!

```
max3 = max 3 -- function Int -> Int

max3 12      -- > 12
```

## Anonieme functies

* voor eenmalige functies kun je de lambda-notatie voor anonieme functies gebruiken
* vorm: `\x -> ...expr met x`
* `\` staat voor lambda ($\lambda$)

```
sqr x = x * x

-- is gelijk aan:

sqr = \x -> x * x

```

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