# Elm overzicht

In dit hoofdstuk geven we een overzicht over de programmeertaal Elm.
Dit is bedoeld om een eerste indruk te krijgen. Het is niet nodig om alles te begrijpen: in de volgende hoofdstukken komen deze onderdelen uitgebreid aan bod.

## Pure functionele taal

Elm is een "pure" functionele programmeertaal: er zijn geen variabelen en er is geen toekenning (assignment). Een functie-aanroep heeft dan geen side-effect.

Eén van de belangrijke gevolgen is dat een functie-aanroep met eenzelfde argument dan altijd hetzelfde resultaat oplevert,
net als in de Wiskunde.
Dit noemen we ook wel *referential transparency* (https://en.wikipedia.org/wiki/Referential_transparency).
Een ander voorbeeld van een pure functionele taal is Haskell. In Haskell is deze "pure" eigenschap de basis voor *lazy evaluation*: als een functie-aanroep altijd hetzelfde resultaat oplevert, dan hoef je deze pas uit te rekenen als je het resultaat nodig hebt.

Niet alle functionele talen zijn "puur". De oudste functionele programmeertaal, LISP, gebruikt variabelen en toekenning.

## Statische typering

Elm heeft *statische typering*: van elke waarde kun je het type bepalen uit de programmatekst, dit is onafhankelijk van de uitvoering van het programma. De Elm-compiler controleert of alle waarden consistent volgens hun type gebruikt worden: elke type-inconsistentie resulteert in een foutmelding.

In de praktijk betekent dit dat de kans op runtime-foutmeldingen aanzienlijk afneemt.

Niet alle functionele talen hebben statische typering. De waarden in LISP zijn dynamisch getypeerd.

Statische typering vind je niet alleen bij functionele programmeertalen: talen als Pascal en Java (en Rust) zijn statisch getypeerd. 

Haskell is een ander voorbeeld van een functionele programmeertaal met statische typering, waarbij de typering veel mogelijkheden biedt voor abstractie.

## Commentaar


## Elementaire data

* Int
* Float
* Bool

(String?)

## Samengestelde data

* List
* tupel
* record

## Functies

* functie-definitie
    * anonieme functie-waarden
* functie-aanroep
* functie als resultaat
* functie als parameter

### Functie-definitie

### Functie-aanroep

### Functie als resultaat

### Functie als parameter

## Elm libraries

## De Elm-architectuur

* interactie in de browser