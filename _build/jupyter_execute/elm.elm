# Elm

Elm is een functionele programmeertaal voor het web.
Hiermee kun je de interactie van een webtoepassing in de browser programmeren, als alternatief voor JavaScript.


## Hello World

Bij het kennismaken met een programmeertaal is één van de eerste programma's die je probeert "Hello World!":
een programma dat de tekst "Hello World!" afdrukt. Als dat werkt, weet je ook dat de hele keten van het invoeren van het programma tot en met het uitvoeren van het programma werkt.

Elm is een *gecompileerde taal*: een Elm-programma moet eerst gecompileerd (vertaald) worden voordat dit uitgevoerd kan worden.
Dit betekent dat je niet zoals gebruikelijk in Jupyter Notebook, een programma stukje voor stukje (cel voor cel) kunt uitvoeren. Je moet aangeven wanneer deze vertaling en uitvoering plaatsvindt; dit doe je met de regel `-- compile-code`. Dit betekent dat alle nog niet uitgevoerde cellen gecombineerd worden tot een programma, dat vervolgens vertaald en uitgevoerd wordt.

Elm is een taal voor het web: het resultaat van een Elm-programma is HTML-code; deze wordt door Jupyter Notebook direct getoond zoals je die in de browser ziet.

De functie die uitgevoerd wordt heet `main`. De Html-functie `text` levert een 

import Html exposing (text)


main =
  text "Hello World!"
  
-- compile-code

De html-elementen in Elm noteer je als `tagname [...attributes...] [...contents...]`, wat overeenkomt met de html-notatie:
`<tagname ...attributes...> ...contents... </tagname>`.

Zo'n `tagname` is in Elm een *functie*, met de lijst van attributen en van inhoudselementen als parameters.

import Html exposing (..)


main =
  div []
    [ h1 [] [ text "My Grocery List" ]
    , ul []
        [ li [] [ text "Black Beans" ]
        , li [] [ text "Limes" ]
        ]
     ]   

-- compile-code

import Html exposing (..)
import Html.Attributes exposing (..)


main =
  div []
    [ h1 [style "color" "red"] [ text "Een link-voorbeeld" ]
    , text "een link: "
    , a [ href "https://infvo.nl" ]
        [ text "infvo website" ]
    ]   

-- compile-code

## Over de notatie

* de indentatie heeft betekenis?
* lijsten komen erg vaak voor; de elementen van een lijst scheiden we met `,`; deze plaatsen we *voor aan de regel*, in plaats van achteraan: dit zorgt ervoor dat je bij het toevoegen of verwijderen van een element alleen die regel hoeft te veranderen. (>>Voorbeeld)
* gebruik van haakjes: alleen om de prioriteit (volgorde van berekenen) aan te geven.

## Functie-definitie

Een functie met twee parameters definieer je in Elm als

```
functienaam parameter0 parameter1  = functie-expressie
```

Elm string-concatenatie: 

Elm getal-conversie, bijv. `toInt` en `fromInt`.

import Html exposing (text)
import String exposing (fromInt)

add a b = a + b

succ x = 
  x + 1

main =
  text (fromInt (add 3 (succ 4)))
  
-- compile-code

Verschil met JavaScript, Python:

JavaScript:

```
function add (a, b) {
       return a + b;
}

```

Python:

```
def add (a, b): 
    return a + b
```

## Functie-evaluatie (1)

* parameters uitrekenen
* functie-body invullen, met waarden voor parameters ingevuld
* vereenvoudigen

```
  add 3 (succ 4)
= ... invullen van functie-body van succ, met x=4
  add 3 (4 + 1)
= ... vereenvoudigen
  add 3 5
= ... invullen van add, met a=3 en b=5
  3 + 5
= ... vereenvoudigen
  8
```

*Opmerking.* De aanpak hierboven geeft het principe duidelijk aan, maar is met betrekking tot namen in de functie-body wat simplistisch. We zullen dat later toelichten.

**UITZOEKEN** wat is de terminologie die in Elm gebruikt wordt voor de verschillende onderdelen van een functie?

import Html exposing (text)
import String exposing (fromInt)

add (a, b) = a + b

succ x = 
  x + 1

main =
  text (fromInt (add (3, (succ 4))))
  
-- compile-code

*Opmerking* Je kunt ook tupels gebruiken: combineren van waarden tussen haakjes, bijvoorbeeld `(3, "hi")`.
Je kunt deze alleen als tupel uitlezen, bijvoorbeeld als functie-parameter.

