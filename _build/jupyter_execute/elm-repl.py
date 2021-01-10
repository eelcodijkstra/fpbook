# Elm repl

"repl" staat voor "read-eval-print-loop": dit is de typische loop van een interpreter, zoals je dat misschien kent van Python.

Hoewel Elm een gecompileerde taal is, is er ook voor Elm een "repl"-programma beschikbaar.
Dit kun je in de commandoregel van Linux, OS X e.d. activeren, als je elm geïnstalleerd hebt.

Hoewel we voor Jupyter Notebook (nog) geen geschikte elm-repl hebben, kun je hier in de Jupyter omgeving op verschillende manieren mee aan de slag:

* in dit (Python) notebook kun je in een cel een shell-opdracht geven, waarin je vervolgens "elm repl" kunt aanroepen. In de regels daarna kun je de opdrachten geven die je anders interactief zou geven. Je voert deze uit door de cel uit te voeren (met het "Run" pijltje bovenin, of met Shift-Return). Zie de voorbeelden verderop.
* je kunt in Jupyter een Terminal-venster openen (rechts boven onder "New"), waar je de opdracht "elm repl" kunt geven. Daarna kun je interactief met Elm aan de slag. Na elke Return verwerkt de interpreter je invoer, totdat deze uitgevoerd kan worden; dan krijg je een resultaat en een nieuwe prompt (`>`).


Enkele dingen om op te letten:

* de prompt van de elm-repl is `>`; als je als prompt `|` krijgt, is dat een teken dat de vorige opdracht volgens elm nog niet compleet is. Dit kun je bijvoorbeeld gebruiken om een functie-definitie over meerdere regels in te voeren. Je moet zo'n meer-regelige definitie wel afsluiten met een lege regel (net als in de interactieve repl).
* elke cel in dit notebook gebruikt een verse elm-interpreter. Je kunt dus niet in de ene cel een functie definiëren die je in de volgende cel gebruikt.
* in de repl-omgeving heb je geen HTML uitvoer tot je beschikking. Gebruik daarvoor een Elm-notebook.

## Voorbeeld

Hieronder een voorbeeld, met een functie-definitie en een functie-aanroep. De extra tekens `>` en `|` die je in de uitvoer ziet, zijn de prompts die nu een beetje als mosterd na de maaltijd komen. 

%%bash
elm repl

sqr : Int -> Int
sqr x = x * x

sqr(13)

Zoals eerder gezegd moet je alle elementen die je gebruikt (imports, functies) in dezelfde cel beschreven worden.

%%bash
elm repl

import List exposing (..)

sqr : Int -> Int
sqr x = x * x

List.map sqr [1,2,3]

Wat is het type van de functie `List.foldr`?

%%bash
elm repl

import List

List.foldr

## Opdrachten

We geven hier enkele opdrachten om met de repl uit te voeren.

1. definieer een functie voor het uitrekenen van het minimum van twee getallen, en demonstreer deze met 3 testgevallen. (Vul de `???` in de cel in.)

%%bash
elm repl

min : ???
min x y = ???

min 2 4
???

2. maak een expressie met behulp van `map` om uit een lijst getallen de lijst met voorafgaande getallen te maken, bijvoorbeeld `[1,2,3]` => `0,1,2`.

%%bash
elm repl

import List

...

List.map ...

3. de operator "+" kun je als functie gebruiken door deze tussen haakjes te schrijven: `(+) a b = a + b`. Gebruik dit om de functie `succ` te definiëren die voor de parameter het volgende getal geeft (succ 3 = 4). Kun je `succ` definiëren zonder parameters links van de `=`? (*Opmerking*: bovenstaande regel voor `(+)` kun je voor elke operator gebruiken, dus bijvoorbeeld ook voor `(::)`.)

%%bash
elm repl

succ : ???
succ = ??? met ...(+)...

succ 3
succ (succ 3)

4. ga na wat het effect is van `foldr (::) [] [1,2,3,4]`. Verklaar dit met de specificatie van `foldr`: `foldr f e [a,b,...,z]` = `a f' (b f' ... (z f' e))` waarin `f'` de infix-versie is van de functie `f` (ofwel: `f a b = a f' b`.)

%%bash
elm repl

import List exposing (..)

foldr ...

5. ga na wat het effect is van `foldl (::) [] [1,2,3,4]`. Verklaar dit met de specificatie van `foldl`: `foldl f e [a,b,...,z]` = `(((e f' a) f' b)...) f' z` waarin `f'` de *omgekeerde* infix-versie is van de functie `f` (ofwel: `f a b = b f' a`.)

%%bash
elm repl

import List exposing (..)

foldl ...