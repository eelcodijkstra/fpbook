import Html exposing (text)
import String exposing (fromInt)

add (a, b) = a + b

succ x = 
  x + 1

main =
  text (fromInt (add (3, (succ 4))))
  
-- compile-code

import Svg exposing (..)
import Svg.Attributes exposing (..)
import String exposing (..)

type Element
  = Rect Int Int Int Int
  | Circle Int Int Int
  
recta = Rect 10 10 300 50
circleb = Circle 50 50 25

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

import Html exposing (..)
import String exposing (..)

type Tree 
  = Node String Tree Tree
  | Nil

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
      

drie = Node "3" Nil Nil
vier = Node "4" Nil Nil
vijf = Node "5" Nil Nil
tree345 = Node "+" drie  (Node "*" vier vijf )

main =
  svg
    [ width "600"
    , height "300"
    , viewBox "0 0 600 300"
    ]
    [ translate (20, 50) [drawTree tree345]
    ]
    
-- compile-code

**Opdracht**

* 



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


