# Bomen - vervolg

In dit hoofdstuk behandelen we algemene (n-aire) bomen, zoals je die bijvoorbeeld tegenkomt in de Elm HTML en SVG-libraries.

We laten bovendien het type van de node in het midden: we kunnen later een boom maken met getallen als knoop, of strings, of een ander type.


import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (..)

type Tree a
  = Node a (List (Tree a))
  | Nil

main = Html.text "Hello"

-- compile-code

## Horizontale vorm 

Een bekende manier om een boom (hiërarchie) weer te geven is de horizontale vorm, waarbij de wortel van de boom "links boven" staat. 
De takken van de boom staan dan lager en ingesprongen.

Deze vorm kom je bijvoorbeeld tegen bij de inhoudsopgave van een boek, of de lijst van bestanden in een filesysteem.

import Html exposing (..)
import String exposing (..)

type Tree a
  = Node a (List (Tree a))

type alias Toc = Tree String

printToc : Toc -> List (Html msg)
printToc toc  =
  printSubtocs [toc] ""

printSubtocs : List Toc -> String -> List (Html msg)
printSubtocs tocs pref =
  case tocs of
    (Node x s) :: xs ->
      let 
        head = Html.div [] [Html.text (pref ++ " " ++ x)]
        subs = printSubtocs s (pref ++ "...")
        next = printSubtocs xs pref
      in
        head :: subs ++ next
    
    [] ->
      []

toc1 = Node "Titel" [hoofdstuk1, hoofdstuk2, hoofdstuk3]
hoofdstuk1 = Node "Hoofdstuk 1" [sectie11, sectie12, sectie13]
sectie11 = Node "Sectie1-1" []
sectie12 = Node "Sectie1-2" []
sectie13 = Node "Sectie1-3" []
hoofdstuk2 = Node "Hoofdstuk 2" [sectie21, sectie22, sectie23]
sectie21 = Node "Sectie2-1" []
sectie22 = Node "Sectie2-2" []
sectie23 = Node "Sectie2-3" []
hoofdstuk3 = Node "Hoofdstuk 3" [sectie31, sectie32, sectie33]
sectie31 = Node "Sectie2-1" []
sectie32 = Node "Sectie2-2" []
sectie33 = Node "Sectie2-3" []


main = div [] (printToc toc1)

-- compile-code

## Opmerkingen

Volgens mij hebben we hier geen Nil meer nodig: een lege lijst met subbomen is voldoende om aan te geven dat er geen subbomen zijn. Een boom zelf bestaat uit 1 wortel; we hebben dan geen lege boom.... (of: de lege boom is een boom zonder subbomen? Eigenlijk is hier sprake van een "bos", nl. een lijst van bomen.)

Vgl. een bestandssysteem: een bestand is een "document", zonder subbomen; of een map, met subbomen. De wortel van een bestandssysteem is altijd een map (`/`) - niet een lege boom.

**Opdracht** gebruik in plaats van div, een ul/li-structuur.

**Opdracht** openklappen?

## Tekenen van een n-aire boom

* tekenen van de subbomen gescheiden door een vaste breedte
* tekenen van de bovenliggende knoop, in het midden van de totale breedte
* per subboom heb je ook een "midden" nodig om de verbinding tussen de bovenliggende knoop en de subbomen te tekenen
    * hoe "midden" is dat midden? - bij 2 subbomen, (of, bij een even aantal subbomen?) in het midden van de tussenruimte.
    * bij meerdere subbomen (of bij een oneven aantal subbomen?): in het midden van de middelste boom?
* eenvoudigste oplossing (voorlopig): het midden van de totale breedte.


-- import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (..)

type Tree a
  = Node a (List (Tree a))

type alias Toc = Tree String

unitwidth = 50
unitheight = 30

translate : (Int, Int) -> List (Svg msg) -> Svg msg
translate (x, y) lst =
  Svg.g
    [transform ("translate(" ++ fromInt(x) ++ "," ++ fromInt(y) ++ ")")]
    lst

twidth : List (Tree a) -> Int
twidth trees =
  case trees of
    (Node head subs) :: next ->
      let
        headw = unitwidth
        subsw = twidth subs
        maxw = Basics.max headw subsw
      in
        maxw + (twidth next)
    
    [] ->
      0
    

drawToc : Toc -> List (Svg msg)
drawToc toc  =
  drawSubtocs [toc] 0

drawSubtocs : List Toc -> Int -> List (Svg msg)
drawSubtocs tocs shift =
  case tocs of
    (Node x s) :: xs ->
      let 
        head = translate (shift + unitwidth // 2, 0) [Svg.text_ [] [Svg.text (x ++ "-" ++ (fromInt maxw))]]
        subs = translate (0, unitheight) (drawSubtocs s (shift + 50))
        maxw = Basics.max unitwidth (twidth s)
        next = drawSubtocs xs (shift + maxw + unitwidth)
      in
        head :: [subs] ++ next
    
    [] ->
      []
      
hseparator = 15 
vseparator = 30
elemwidth = 50

-- bij de breedte van een lijst moeten we rekening houden met 3 gevallen:
-- de lege lijst (0), 1 element (geen separator), meerdere elementen (separators)

treesWidth : List (Int, Svg msg) -> Int
treesWidth lst =
  case lst of
    (tw, t) :: snd :: ts ->
      tw + hseparator + treesWidth (snd :: ts)
      
    (tw, t) :: [] ->
      tw
      
    [] ->
      0

-- het resultaat vran drawTrees is een lijst van getekende bomen.
-- elke boom heeft een eigen breedte; we hebben de breedte van de totale lijst
-- nog niet bepaald, dat komt pas bij de omvattende boom (als die er is.)
-- eventueel later: per deel-boom ook een "midden-punt".

drawTrees : List Toc -> List (Int, Svg msg)
drawTrees lst =
  case lst of
    t :: ts ->
      let
        (headwidth, headsvg) = drawTree t 0
        tail = drawTrees ts
      in
        (headwidth, headsvg ) :: tail
      
    [] ->
      []
      
pushdownTrees : List (Int, Svg msg) -> Int -> List (Svg msg)
pushdownTrees lst pref =
  case lst of
    (tw, t) :: ts :: x ->
      (translate (pref, vseparator) [t]) :: (pushdownTrees (ts :: x) (pref + tw + hseparator))
      
    (tw, t) :: [] ->
      [translate (pref, vseparator) [t]]
    
    [] ->
      []
      
drawTree : Toc -> Int -> (Int, Svg msg)
drawTree tree pref =
  case tree of
    Node t subs ->
      let     
        subtrees = drawTrees subs
        subwidth = 
          if subtrees == [] then
            elemwidth
          else
            treesWidth subtrees
 --       head = translate (pref + subwidth // 2, 0) [Svg.text_ [] [Svg.text (t ++ "-" ++ (fromInt subwidth))]]
        head = translate (pref + subwidth // 2, 0) [Svg.text_ [] [Svg.text (t)]]
        placedtrees = pushdownTrees subtrees pref
      in
        (subwidth, (translate (0, 0) (head::placedtrees)))
    
    
-- een Tree heeft maar 1 alternatief...

drawT : Toc -> Svg msg
drawT toc =
  let
    (w, t) = drawTree toc 0
  in
    t

toc1 = Node "Titel" [hoofdstuk1, hoofdstuk2, hoofdstuk3]
hoofdstuk1 = Node "H 1" [sectie11, sectie12, sectie13]
sectie11 = Node "S 1-1" []
sectie12 = Node "S 1-2" []
sectie13 = Node "S 1-3" []
hoofdstuk2 = Node "H 2" [sectie21, sectie22, sectie23]
sectie21 = Node "S 2-1" []
sectie22 = Node "S 2-2" []
sectie23 = Node "S 2-3" []
hoofdstuk3 = Node "H 3" [sectie31, sectie32, sectie33]
sectie31 = Node "S 2-1" []
sectie32 = Node "S 2-2" []
sectie33 = Node "S 2-3" []


main = 
  svg
    [ width "800"
    , height "400"
    , viewBox "0 0 800 400"
--    , stroke "black"
--    , strokeWidth "0.5"
--    , fill "None"
    ]
    [ (translate (10, 10) [Svg.text_ [] [text "hi"]])
    , (translate (100,100) [drawT toc1])
    ]
    
--    ++ ( drawToc sectie11 ) ++ [Svg.text "hi"])

-- compile-code



node = translate (lw + unitwidth // 2 - swidth str, 0) [Svg.text_ [] [text str]]

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