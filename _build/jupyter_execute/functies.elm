# Functies

* functie-definitie
    * parameters
    * "body", functie-expressie
* functie-aanroep
    * "functionele rekenmodel"
    * NB: eerst uitrekenen van functie-resultaat * in de omgeving van de functie-definitie*; dan vervangen van de aanroep door het resultaat.
* "referential transparency", in het bijzonder voor functie-aanroepen

## Functie-compositie

Met functie-compositie maak je een nieuwe functie uit twee bestaande functies.

Voorbeeld: de functie `isOdd` kun je maken uit `isEven` en `not`. Elm heeft twee operatoren voor het samenstellen van functies:

* `(f << g) x == f ( g x )` 
* `(g >> f) x == f ( g x )`

De "pijl" geeft de richting aan van de data; je kunt `f << g` lezen als "f na g".

isEven : Int -> Bool
isEven x = modBy 2 x == 0

isOdd : Int -> Bool
isOdd = not << isEven

evens = List.filter isEven (List.range 1 10)
odds = List.filter isOdd (List.range 1 10)

