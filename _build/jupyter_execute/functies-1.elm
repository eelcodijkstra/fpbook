# Functies (1)

**Onderwerpen:** functie-definitie; functie-aanroep; typering van functies; Currying; anonieme functies.


Een functie-aanroep heeft de vorm: `fname par1 par2 ...`: de naam van de functie gevolgd door de parameter-expressies.
In tegenstelling tot veel andere programmeertalen worden hierbij geen haakjes en komma's gebruikt.
Soms zijn haakjes nodig omdat functie-aanroep sterker bindt dan optellen of vermenigvuldigen, of omdat een expressie van rechts naar links uitgerekend moet worden.

Enkele voorbeelden van functie-aanroepen:

```elm
double 3
max 3 4
succ (double 4)
max (double 4) (succ 9)
List.map f [1,2,3]
```

Zonder haakjes zou `succ double 4` verwerkt worden als `(succ double) 4` (wat een foutmelding geeft).

## Functie-definitie

Voordat je een functie kunt gebruiken moet deze gedefinieerd zijn.
Je kunt een voorgedefinieerde functie gebruiken uit een geïmporteerde module (*package*),
of een zelf-gedefinieerde functie.

Een functie-definitie heeft de vorm: `fname pname1 pname2 pname3 ... = ...expr in pname1, ...`
De namen van de parameters kun je vrij kiezen, deze hebben alleen betekenis in de definitie,
niet bij de aanroep.

Enkele voorbeelden van functie-definities:

```elm
double x = x + x

max x y = if x >= y then x else y

succ x = x + 1
```

De betekenis van zo'n definitie is dat je een functie-aanroep kunt vervangen door het rechterlid van de definitie (de "body"), waarbij je de parameternamen vervangt door de parameter-waarden in de aanroep.

Merk op dat hier, net als bij de aanroep, geen haakjes gebruikt worden.

## Rekenen met functies

In het voorbeeld hieronder werken we een functie-aanroep met de hand uit,
waarbij we steeds een aanroep vervangen door het bijbehorende rechterlid van de definitie.
Bij elke stap beschrijven we welke regel we gebruiken.

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

Dit voorbeeld is nog erg eenvoudig, maar het gaat om de systematische aanpak.
Het gebruik hiervan bij de lastige functies die we later tegenkomen helpt om de principes onder de knie te krijgen.

Nog een voorbeeld, nu met een `if`-expressie. De `if`-regel is:
```
   if True then x else y   => x
   if False then x else y  => y
```

We gebruiken hieronder de functie: `max x y = if x >= y then x else y`.

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

## Voorbeeld: bulletlist

We hebben eerder het onderstaande programma gezien, als voorbeeld van het benutten van functies in de context van HTML.

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

Op basis van de bovenstaande uitleg over functies is de functie `bulletlist` al wat beter te begrijpen: 

```
bulletlist attrs lst =
  ul attrs (map (\elt -> li [] [text elt]) lst)
```

* dit is de definitie van een functie met twee parameters, `attrs` en `lst`.
* `ul attrs (...)` is de aanroep van de functie `ul` met twee parameters
* `map (...) lst` is de aanroep van een functie met twee parameters,
* waarvan de eerste parameter een *anonieme functie* is:
* `\elt -> li [] [text elt]`
* hierin is `li [] [...]` weer de aanroep van een functie met 2 parameters.
* de functies `ul` en `li` zijn Elm-functies die overeenkomen met de HTML-tags `<ul>` en `<li>`

In het volgende hoofdstuk behandelen we de functie `map f lst`: het resultaat is een lijst waarin `f` toegepast is op elm element van de oorspronkelijke lijst.

```
  map double [1,3,5] == [double 1, double 3, double 5] == [2, 6, 10]
```

Ga na dat je met het gebruik van `map` in het HTML-voorbeeld een lijst-element (`li`) maakt voor elk element van de lijst `lst`.

We hebben bij deze functie `bulletlist` nog geen typering gegeven. Ga zelf na hoe deze eruit zou kunnen zien.




