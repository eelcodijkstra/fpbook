# Bomen

* boom als recursieve datastructuur
* noteren van een samengestelde boom
* afdrukken van een boom op verschillende manieren
* lukt het ook om een boom te tekenen?

import Html exposing (text)
import String exposing (fromInt)

add (a, b) = a + b

succ x = 
  x + 1

main =
  text (fromInt (add (3, (succ 4))))
  
-- compile-code

## Custom types

Soms moet je in één type een aantal alternatieven combineren, waarbij je aan de hand van een "tag" weet met welk alternatief je te maken hebt.
In Elm gebruik je daarvoor *Custom types*. Een algemene term hiervoor is "discriminated union": een vereniging van alternatieven waarbij je deze alternatieven kunt onderscheiden ("discimineren").

> Je kunt dit vergelijken met de elementen in HTML of SVG: met behulp van tags zoals "h1", "div", of "ul" onderschied je de verschillende soorten elementen.

Beschouw het volgende voorbeeld: een grafisch element is een rechthoek (met beginpunt (x, y), breedte en hoogt) of een cirkel (met beginpunt (x, y) en straal).

import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (..)

type Element
  = Rect Int Int Int Int
  | Circle Int Int Int
  
recta = Rect 10 10 300 50
circleb = Circle 50 50 25

In een functie voor het verwerken van een grafische element (bijvoorbeeld voor het tekenen daarvan) onderscheid je de verschillende alternatieven met behulp van de `case`-constructie:

drawElement elt =
  case elt of
    Rect rx ry rw rh ->
      rect
        [ x (fromInt rx)
        , y (fromInt ry)
        , width (fromInt rw)
        , height (fromInt rh)
        , fill "none"
        , stroke "black"
        , strokeWidth "2"
        ]
        []
    Circle x y cr ->
       circle
         [ cx (fromInt x)
         , cy (fromInt y)
         , r (fromInt cr)
         , fill "none"
         , stroke "red"
         , strokeWidth "2"
         ]
         []

main =
  svg
    [ width "400"
    , height "200"
    , viewBox "0 0 400 200"
    ]
    [ drawElement recta
    , drawElement circleb
    ]
 
-- compile-code

Opmerking: dit voorbeeld lijkt wat gekunsteld: je maakt je eigen grafische elementen, terwijl je die al als SVG-elementen tot je beschikking hebt. Het is zelfs nog erger: de functies in de Elm-library zijn gebaseerd op SVG-elementen die als data-elementen gedefinieerd zijn, te vergelijken met de HTML-elementen.


Een volgende stap is dat we grafische elementen kunnen groeperen; dit combineren we met translatie, rotatie en schaling.

import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (..)

type Element
  = Line Int Int Int Int -- (fromx, fromy), (tox, toy)
  | Rect Int Int Int Int -- (x,y), widht, height
  | Circle Int Int Int -- (x, y), radius
  | Translate Element Int Int -- translate (x, y)
  | Rotate Element Int -- rotate r degrees
  | Scale Element Float -- scale factor
  | Group (List Element) -- group elements
  
recta = Rect 10 10 300 50
circleb = Circle 50 50 25
movedc = Translate circleb 100 100
rotateda = Rotate recta 45
groupd = Group [recta, circleb, movedc]
translatedd = Translate groupd 20 20
linea = Line 0 0 400 400
lineb = Line 0 400 400 0

drawElement elt =
  case elt of
    Line fromx fromy tox toy ->
      line
        [ x1 (fromInt fromx)
        , y1 (fromInt fromy)
        , x2 (fromInt tox)
        , y2 (fromInt toy)      
        ]
        []
    Rect rx ry rw rh ->
      rect
        [ x (fromInt rx)
        , y (fromInt ry)
        , width (fromInt rw)
        , height (fromInt rh)     
        ]
        []
    Circle x y cr ->
       circle
         [ cx (fromInt x)
         , cy (fromInt y)
         , r (fromInt cr)
         ]
         []
    Translate e x y ->
        g
        [ transform ("translate(" ++ fromInt x ++ "," ++ fromInt y ++ ")")
        ]
        [ drawElement e ]
    Rotate e r ->
        g
        [ transform ("rotate(" ++ fromInt r ++ ")")
        ]
        [ drawElement e ]
    Scale e s ->
        g
        [ transform ("scale(" ++ fromFloat s ++ ")")
        ]
        [ drawElement e ]
    Group elts ->
        g
        []
        (List.map drawElement elts)


  

house = 
  Group 
    [ Line 0 40 0 20
    , Line 0 20 10 0
    , Line 10 0 20 20
    , Line 20 20 20 40
    , Line 20 40 0 40
    ]

main =
  svg
    [ width "400"
    , height "400"
    , viewBox "0 0 400 400"
    , fill "none"
    , stroke "black"
    , strokeWidth "1"
    ]
    [ drawElement linea
    , drawElement lineb
    , drawElement house
    , drawElement (Translate house 50 50)
{--    
    , drawElement recta  
    , drawElement circleb
--}    
    , drawElement movedc
    , drawElement rotateda
    , drawElement translatedd 
--}    
    ]
 
-- compile-code

Met het "group" element hebben we een recursieve structuur gemaakt. (Net als in HTML of in SVG.)
(Dit geldt overigens ook voor Translate enz.) Dit betekent dat de `drawElement` functie ook recursief is/moet zijn.

**Alternatief** 

* geef de Translate functie een lijst van elementen mee.
* introduceer ook de lijn als primitief element
* een driehoek is een mooi voorbeeld van een groep.
    * een driehoek is geen primitief element - maar dat kunnen we er wel van maken
    * ander voorbeeld: huisje
* we hebben hierboven de transformaties gedefinieerd in het datatype. We kunnen deze ook als functies definiëren die de attributen veranderen. Dat vereenvoudigt de `drawElement` functie. (Maar, waar laten we de kleur? Daarvoor hebben we nu in de data geen plaats... in tegenstelling tot in het SVG-type....) 
* Mogelijk kunnen we de "group" daarvoor gebruiken, om andere attributen voor de groep te zetten. Dan kun je ook nog altijd een context voor een enkel element zetten...)
* Als we de group gebruiken voor het zetten van attributen, dan kunnen we ook de translate e.d. via die attributen laten verlopen.
* svg-elementen kunnen recursief zijn (in tegenstelling tot HTML)...

**Voorkennis** We gebruiken hier de `List.map` functie. Deze moeten we hiervoor behandelen.



import Html exposing (..)
import String exposing (..)

type Tree 
  = Node String Tree Tree
  | Nil

Enkele voorbeelden:

a = Node "aap" (Node "noot" Nil Nil) (Node "mies" Nil Nil)
b = Node "vuur" a Nil

prefix tree =
  case tree of
  Node str left right -> str ++ (prefix left) ++ (prefix right)
  Nil -> ""

infix tree =
  case tree of
  Node str left right -> (infix left) ++ str ++ (infix right)
  Nil -> ""

postfix tree =
  case tree of
  Node str left right -> (postfix left) ++ (postfix right) ++ str
  Nil -> ""

main =
  text ("OK" ++ postfix b)
-- compile-code

functie voor het afdrukken van een boom, in prefix:

Tekenen van een boom.

Hier komt wat meer bij kijken: we moeten met het inspringen (positie) van de bovenste knoop rekening houden met de breedte van de boom eronder.

We gebruiken een proces in twee stappen: we zetten de boom om in een andere boom die we afbeelden op SVG(?)




import Svg exposing (..)
import Svg.Attributes exposing (..)

main =
  svg
    [ width "400"
    , height "400"
    , viewBox "0 0 400 400"
    ]
    [ rect
        [ x "10"
        , y "10"
        , width "100"
        , height "100"
        , stroke "black"
        , strokeWidth "3"
        , fill "None"
        ]
        []
    , circle
        [ cx "100"
        , cy "100"
        , r "30"
        , color "green"
        , stroke "red"
        , strokeWidth "3"
        , fill "None"
        ]
        []
    , text_ 
        [ x "200", y "200"] [text "Hello"]   
    ]
    
-- compile-code

## Andere voorbeelden

* expressie-boom; afdrukken op verschillende manieren; "vertalen", bijv. voor een eenvoudige register-taal?; uitrekenen.
* DOM als boom; HTML-bomen
* 

## Belangrijke lessen

* de structuur van de verwerking volgt de structuur van de data
    * dit kunnen we straks ook voor lijsten doen
* case-analysis moet compleet zijn: de Elm-compiler bewaakt dat?


## Volgende stap(pen)

* het gebruik van functies om te tekenen; functie als abstractie-mechanisme, met de mogelijkheid om te rekenen: veel compactere notatie dan de pure data-notatie.
* welke volgorde gebruiken we bij group voor de attributen en de elementen: dat bepaalt welke partiële parametrisatie we kunnen gebruiken.

## Tekenen van een boom

* tekenen van een boom, uitgaande van een datastructuur

import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (fromInt, length)

type Tree 
  = Node String Tree Tree
  | Nil

translate : (Int, Int) -> List (Svg msg) -> Svg msg
translate (x, y) lst =
  Svg.g
    [transform ("translate(" ++ fromInt(x) ++ "," ++ fromInt(y) ++ ")")]
    lst

unitwidth = 30
unitheight = 40

twidth : Tree -> (Int, Int)
twidth t =
  case t of        
    Node str left right ->
      let
        (lw, _) = twidth left
        (rw, _) = twidth right
      in
        (lw + unitwidth + rw, lw + (unitwidth // 2))

    Nil ->
      (0, 0)
      
swidth str =
  length str * 4

drawLine : (Int, Int) -> (Int, Int) -> Svg msg
drawLine (xa, ya) (xb, yb) =
  Svg.line
    [ x1 (fromInt xa)
    , y1 (fromInt ya)
    , x2 (fromInt xb)
    , y2 (fromInt yb)
    , stroke "black"
    , strokeWidth "1"    
    ]
    []

drawTree : Tree -> Svg msg
drawTree t =
  case t of
    Node str Nil Nil ->
      translate (unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text str]]
      
    Node str Nil right ->
      let
        (rw, rm) = twidth right
        rtree = translate (unitwidth, unitheight) [drawTree right]
        node = translate (unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text str]]
        rightedge = drawLine (unitwidth // 2, 5) (unitwidth + rm, unitheight - 15)
      in
        Svg.g [] [node, rtree, rightedge]

    Node str left Nil ->
      let
        (lw, lm) = twidth left
        ltree = translate (0, unitheight) [drawTree left]
        node = translate (lw + unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text str]]
        leftedge = drawLine (lw + unitwidth // 2, 5) (lm, unitheight - 15)
      in
        Svg.g [] [ltree, node, leftedge]     
        
    Node str left right ->
      let
        (lw, lm) = twidth left
        (rw, rm) = twidth right
        ltree = translate (0, unitheight) [drawTree left]
        rtree = translate (lw + unitwidth, unitheight) [drawTree right]
        node = translate (lw + unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text str]]
        leftedge = drawLine (lw + unitwidth // 2, 5) (lm, unitheight - 15)
        rightedge = drawLine (lw + unitwidth // 2, 5) (lw + unitwidth + rm, unitheight - 15)
      in
        Svg.g [] [ltree, node, rtree, leftedge, rightedge]
    Nil ->
      Svg.text_ [] [text "."]
      

tree0 = Nil
tree1 = Node "hi" Nil Nil
tree2 = Node "Hoi" tree1 tree1
tree3 = Node "moi" tree2 tree2
tree4 = Node "goeie" (tree3)  (Node "hi" (Nil) (Node "???" tree1 Nil) )

test x =
  Svg.g
   []
   [ translate (10, 10) [drawTree tree4]
   ]

main =
  svg
    [ width "800"
    , height "400"
    , viewBox "0 0 800 400"
--    , stroke "black"
--    , strokeWidth "0.5"
--    , fill "None"
    ]
    [ test 1
    ]
    
-- compile-code

## Opmerkingen

* je kunt kennelijk niet de onderdelen van een Node opvragen? Bijvoorbeeld als je de attributen van een Node achteraf wilt wijzigen. Anders gezedgd: een nieuwe Node met gewijzigde attributen wilt opleveren.

```
     transform="rotate(-10 50 100)
                translate(-36 45.5)
                skewX(40)
                scale(1 0.5)">
```                

* kennelijk heeft het globale "stroke"-attribuut gevolgen voor de dikte van de letters. Kunnen we dat omzeilen, want ik wil dit wel graag globaal houden.

* het is denk ik mooier om de boom symmetrisch te tekenen. We moeten dan voor de breedte het maximum van de beide subbomen gebruiken.

    * als we de boom niet symmetrisch tekenen, moeten we rekening houden met de positie van het label aan de top: dat hoeft dan immers niet in het midden te staan...
    * het symmetrisch tekenen levert een minder fraai resultaat als de eigenlijke boom niet symmetrisch is, vooral als 1 subboom duidelijk breder is dan de rest.
    
* een mogelijkheid (nog verder uitzoeken/uitwerken): twidth levert de breedte van de beide subbomen, en daarmee ook een positie voor het midden van de volledige boom.

* SVG heeft geen "leeg" element (anders dan bijv. een lege groep). We zouden anders het tekenen van een boom kunnen vereenvoudigen?
* maar, we moeten dan niet alleen de boom niet tekenen, maar ook de verbinding naar de boom niet....

* dit is een oplossing voor een (max.) binaire boom; een volgende stap is het generaliseren naar een n-aire boom; dat hebben we bijv. nodig voor taalstructuren.



import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (fromInt, length)

type Tree 
  = Node String Tree Tree
  | Nil

translate : (Int, Int) -> List (Svg msg) -> Svg msg
translate (x, y) lst =
  Svg.g
    [transform ("translate(" ++ fromInt(x) ++ "," ++ fromInt(y) ++ ")")]
    lst

unitwidth = 50
unitheight = 30

twidth : Tree -> Int
twidth t =
  case t of
    Node str Nil Nil ->
      unitwidth
    Node str left Nil ->
      (twidth left) + unitwidth + (twidth left)
    Node str Nil right ->
      (twidth right) + unitwidth + (twidth right)
    Node str left right ->
      let maxwidth = Basics.max (twidth left) (twidth right) in
        (maxwidth) + unitwidth + (maxwidth)
    Nil ->
      0
      
swidth str =
  length str * 5

drawLine : (Int, Int) -> (Int, Int) -> Svg msg
drawLine (xa, ya) (xb, yb) =
  Svg.line
    [ x1 (fromInt xa)
    , y1 (fromInt ya)
    , x2 (fromInt xb)
    , y2 (fromInt yb)
    , stroke "black"
    , strokeWidth "1"    
    ]
    []

drawTree : Tree -> Svg msg
drawTree t =
  case t of
    Node str Nil Nil ->
      translate (unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text str]]
      
    Node str Nil right ->
      let
        rtree = translate ((twidth right) + unitwidth, unitheight) [drawTree right]
        node = translate ((twidth right) + unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text (str ++ " " ++ fromInt (twidth right))]]
        rightedge = drawLine ((twidth right) + unitwidth // 2, 5) ((twidth right) + unitwidth + (twidth right)// 2, unitheight - 15)
      in
        Svg.g [] [node, rtree, rightedge]

    Node str left Nil ->
      let
        ltree = translate (0, unitheight) [drawTree left]
        node = translate (twidth left + unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text (str ++ " " ++ fromInt (twidth left)) ]]
        leftedge = drawLine (twidth left + unitwidth // 2, 5) (twidth left // 2, unitheight - 15)
      in
        Svg.g [] [ltree, node, leftedge]     
        
    Node str left right ->
      let
        maxwidth = Basics.max (twidth left) (twidth right)
        ltree = translate (0, unitheight) [drawTree left]
        rtree = translate (maxwidth + unitwidth, unitheight) [drawTree right]
        node = translate (maxwidth + unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text (str ++ " " ++ fromInt (maxwidth))]]
        leftedge = drawLine (maxwidth + unitwidth // 2, 5) (maxwidth // 2, unitheight - 15)
        rightedge = drawLine (maxwidth + unitwidth // 2, 5) (maxwidth + unitwidth + (maxwidth)// 2, unitheight - 15)
      in
        Svg.g [] [ltree, node, rtree, leftedge, rightedge]
    Nil ->
      Svg.text_ [] [text "NIL"]
      

tree0 = Nil
tree1 = Node "hi" Nil Nil
tree2 = Node "Hoi" tree1 tree1
tree3 = Node "moi" tree2 tree2
tree4 = Node "goeie" (tree3)  (Node "hi" (tree1) (Node "???" tree1 tree1) )

test x =
  Svg.g
   []
   [ translate (10, 10) [drawTree tree4]
   ]

main =
  svg
    [ width "800"
    , height "400"
    , viewBox "0 0 800 400"
--    , stroke "black"
--    , strokeWidth "0.5"
--    , fill "None"
    ]
    [ test 1
    ]
    
-- compile-code



import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (fromInt, length)

type Tree 
  = Node String Tree Tree
  | Nil

translate : (Int, Int) -> List (Svg msg) -> Svg msg
translate (x, y) lst =
  Svg.g
    [transform ("translate(" ++ fromInt(x) ++ "," ++ fromInt(y) ++ ")")]
    lst

unitwidth = 30
unitheight = 50

twidth : Tree -> (Int, Int)
twidth t =
  case t of        
    Node str left right ->
      let
        (lw, _) = twidth left
        (rw, _) = twidth right
      in
        (lw + unitwidth + rw, lw + (unitwidth // 2))

    Nil ->
      (0, 0)
      
swidth str =
  length str * 4

drawLine : (Int, Int) -> (Int, Int) -> Svg msg
drawLine (xa, ya) (xb, yb) =
  Svg.line
    [ x1 (fromInt xa)
    , y1 (fromInt ya)
    , x2 (fromInt xb)
    , y2 (fromInt yb)
    , stroke "black"
    , strokeWidth "1"    
    ]
    []

drawTree : Tree -> Svg msg
drawTree t =
  case t of        
    Node str left right ->
      let
        (lw, lm) = twidth left
        (rw, rm) = twidth right
        tm = lw + unitwidth // 2  -- top midden
        leftbranch = 
          if left == Nil then
            []
          else
            [ translate (0, unitheight) [drawTree left]
            , drawLine (tm, 5) (lm, unitheight - 15)
            ]
        rightbranch = 
          if right == Nil then
            []
          else
            [ translate (lw + unitwidth, unitheight) [drawTree right]
            , drawLine (tm, 5) (lw + unitwidth + rm, unitheight - 15)
            ]
        node = translate (tm - swidth str, 0) [Svg.text_ [] [text str]]
      in
        Svg.g [] (leftbranch ++ [node] ++ rightbranch)
        
    Nil ->
      Svg.text_ [] [text "."]
      

tree0 = Nil
tree1 = Node "hi" Nil Nil
tree2 = Node "Hoi" tree1 tree1
tree3 = Node "moi moi moi" tree2 tree2
tree4 = Node "goeie moarn" (tree3)  (Node "himmmmmmm" (Nil) (Node "???" tree1 Nil) )

test x =
  Svg.g
   []
   [ translate (10, 10) [drawTree tree4]
   ]

main =
  svg
    [ width "800"
    , height "400"
    , viewBox "0 0 800 400"
--    , stroke "black"
--    , strokeWidth "0.5"
--    , fill "None"
    ]
    [ test 1
    ]
    
-- compile-code

