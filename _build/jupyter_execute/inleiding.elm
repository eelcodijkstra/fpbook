# Inleiding

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


```{toctree}
:hidden:
:titlesonly:


functies-1
lijsten-1
lijsten-2
functies-2
```
