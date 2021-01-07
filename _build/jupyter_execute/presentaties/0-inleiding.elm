# Functioneel programmeren - in Elm

## Functioneel programmeren

Stijl van programmeren waarin *functies* centraal staan

* functie-definitie
* functie-aanroep
* functie-waarden
    * als resultaat
    * als parameter
    * als samenstelling van functies 
    
Functionele stijl kun je in veel talen toepassen. 

## Elm - als functionele taal

* "puur functioneel": geen variabelen, toekenning
* "statische typering" - vgl. ook Pascal, Java, Rust, enz.
* "gecompileerde taal" - i.t.t. Python, JavaScript

Elm is bedoeld voor uitvoering in de browser, als alternatief voor JavaScript.

## Elm in de browser

HTML - voorbeeld:

```html
<div style="color: red;">
  <h3 style="color: blue;"> Kopje </h3>
  <p> Tekst tekst tekst </p>
</div> 
```

Elm - voorbeeld:

```elm
  div [style "color" "red"]
    [ h3 [style "color" "blue"] [ text "Kopje"]
    , p  []  [ text "Tekst tekst tekst" ]
    ] 
```
* `div`,`h3`, `p`, `text`, `style` zijn *functies*
* met een attributen-lijst en een elementen-lijst

import Html exposing (div, h3, p, text)
import Html.Attributes exposing (style)

main =
  div [style "color" "red"]
    [ h3 [style "color" "blue"] [ text "Kopje"]
    , p  []  [ text "Tekst tekst tekst" ]
    ] 

-- compile-code

Compleet Elm-programma

* `import` geeft gebruikte *packages* aan
* `-- compile-code` alleen voor Jupyter Notebook
* uitvoeren in Notebook: 
    * selecteer cel
    * Shift-Return (of "run"-pijltje bovenin)

Andere omgevingen voor uitvoeren van Elm:

* https://elm-lang.org/try (web, online)
* https://ellie-app.com (web, online)
* elm-repl
    * in Terminal `elm repl`

## Benutten van functies


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

## Functies

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

