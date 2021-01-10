# Inleiding Jupyter Notebooks

Voor het oefenen met Elm gebruiken we [Jupyter Notebooks](https://jupyter.org).
Hiermee kun je op een interactieve manier aan de slag, waarbij je alle vrijheden hebt om je eigen varianten uit te proberen.

De uitleg hieronder beschrijft eerst de principes van Jupyter notebooks, en de manier waarop we deze voor Elm gebruiken.

## Cellen: Markdown en Code

Een notebook bestaan uit cellen.

Je selecteert een cel door op de cel te klikken, of in de kantlijn links van de cel.
Je selecteert de volgende/vorige cel met de pijltjestoetsen up/down.
**Selecteer nu deze cel.**

Er zijn twee soorten cellen: **Code** en **Markdown**. 
Het type van de geselecteerde cel vind je in de interface-balk bovenin.
Met dit menu kun je ook het type van de cel veranderen
Deze cel is een **Markdown** cel, de volgende cel is een (Elm) **Code** cel. **Controleer dit.**

import Html exposing (div, p, text)
import Html.Attributes exposing (style)

main =
  div [style "color" "blue"]
    [  p  []  [ text "Dit is de uitvoer van een Elm programma" ]
    ] 

-- compile-code

## Code-cellen

**Uitvoeren van een cel**. De cel hierboven is een Code-cel, met daarin een Elm programma. **Voer deze cel uit (Run)**:

1. Selecteer de cel
2. Voer de cel uit, via Run (pijltje) in het menu hierboven, of via SHIFT-RETURN.

Zoals je ziet verschijnt het resultaat van het Elm-programma onder de cel.

> Bij het uitvoeren van een Code-cel verschijnt er in de kantlijn een getal tussen rechte haken. Dit geeft de volgorde van de uitgevoerde cellen aan. Als je de cel nogmaals uitvoert, zie je een volgend getal.

**Aanpassen van een cel.** Je kunt de code in een Code-cel eenvoudig aanpassen: selecteer de cel, en verander de tekst.

**Verander de Elm-expressie in de cel hieronder van** `2 + 3` **in:** `2 + 3 * 5` en **voer de cel uit**.

import Html exposing (div, p, text)
import String

main =
   p  []  [ text ("2 + 3 = " ++ (String.fromInt( 2 + 3 )))]

-- compile-code

## Code: meerdere cellen

Jupyter Notebooks zijn in de eerste plaats gemaakt voor interpreter-talen zoals Python, met tekst-invoer en -uitvoer.
Elm is in twee opzichten anders: (i) het is een gecompileerde taal; (ii) Elm werkt in een HTML- en SVG-omgeving.

> Je kunt Elm ook als "repl" gebruiken, met tekst-uitvoer en -invoer. Zie daarvoor [elm-repl notebook](elm-repl.ipynb).

De manier waarop Elm in deze notebooks werkt is als volgt:

* bij het uitvoeren van een code-cel wordt de code opgespaard totdat de regel "-- compile-code" gevonden wordt. De opgespaarde code wordt dan aangeboden aan de compiler, en als deze correct bevonden is, uitgevoerd in een HTML/SVG-omgeving.
* na het uitvoeren van een programma begin je weer met een schone lei; er worden geen resultaten van de vorige uitvoering bewaard.

Om te experimenteren met Elm is het dan handiger als een cel een compleet Elm-programma bevat; je kunt het dan aanpassen en uitvoeren, zonder dat je steeds andere cellen hoeft uit te voeren.

> In de presentaties zijn de programma's soms over meerdere cellen verdeeld, omdat je een groot programma niet op één slide kunt tonen.

**Opeenvolgende cellen.** Hieronder zie je een voorbeeld van een Elm-programma dat over meerdere cellen verdeeld is. Deze moet je dan in de goede volgorde uitvoeren, pas bij de laatste cel zie je het resultaat.

**Voer de onderstaande 2 cellen achtereenvolgens uit**

import Html exposing (div, p, text)
import Html.Attributes exposing (style)
import String

main =
  div [style "color" "blue"]
    [  p  []  [ text ("2 + 3 = " ++ (String.fromInt(2 + 3)))]
    ] 

-- compile-code

## Markdown cellen

Je kunt de tekst in een Markdown-cel aanpassen door deze in **edit-mode** te brengen.
Dit doe je door een dubbel-klik op de cel.
Je herkent deze mode aan het gebruik van een ander lettertype.

**Pas de inhoud van deze cel aan**

Een Markdown-cell breng je van edit-mode naar de geformatteerde tekst-mode door deze cel uit te voeren.
Je *voert een cel uit* (*Run*) door op het pijl-symbool bovenin te klikken, of door SHIFT-RETURN.

**Voer de cel hierboven uit om deze weer in geformatteerde tekst-mode te brengen.**

* Het uitvoeren van een Markdown-cel resulteert in het formatteren van de tekst.
* Het uitvoeren van een Code-cel resulteert in het uitvoeren van de code.

## Kernel

Een Notebook gebruikt een *Kernel*: dat is de interpreter of compiler die de code-cellen verwerkt. Soms komt deze Kernel in een onbruikbare toestand; of je wilt echt met een schone lei beginnen. In zo'n geval kun je de Kernel opnieuw opstarten: zie het Kernel-menu bovenin. (Ik gebruik meestal: Restart Kernel and Cleat all outputs: een schone lei.)

Voor Elm gebruiken we de Elm-kernel; voor elm-repl de Python-kernel, met in de cellen een "bash-shell". In dat laatste geval kun je commandoregel-opdrachten geven.

## Tussenvoegen en verwijderen van cellen

Je kunt een cel toevoegen na de huidge cel met het `+`-symbool in het interface bovenin.

De huidige cel verwijder je met het schaar-symbool in het interface bovenin.
(Met Z -undo cell operation- maak je dat weer ongedaan.)

Je kunt een cel verplaatsen met behulp van het handvat in de linker kantlijn.
(Dit werkt alleen voor de nieuwere JupyterLab, niet voor Jupyter Notebook.)

## Samenvatting

* een notebook bestaat uit cellen; een cel kan *tekst* bevatten (Markdown), zoals deze cel, of *code*.
* je voert een cel uit door deze te selecteren (cursor in de cel), en vervolgens SHIFT-RETURN in te toetsen.
  Ook het pijltje in de opdrachtenbalk hierboven kun je gebruiken.
* onder de cel zie je dan de uitvoer van deze opdracht.
* om problemen te voorkomen voer je cellen alleen uit *in de volgorde in het notebook*.
* je kunt eventueel opnieuw beginnen door de "Kernel" opnieuw te starten (via het cirkeltje, als bij een reload in de browser).
* zie voor meer informatie: help, en [tutorial](https://www.dataquest.io/blog/jupyter-notebook-tutorial/)

De meeste code-cellen kun je zo uitvoeren; probeer de code en de uitvoer te begrijpen.
Bij sommige opdrachten moet je de code aanpassen, en dan de cel uitvoeren.

