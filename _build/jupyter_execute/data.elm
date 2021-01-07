# data

* basistypes: Int, Char, Boolean, Float, String
* samenstelling: List (array?); NB: uniform wat waarden betreft
* samenstelling: Record ("Cartesisch product"); NB: hoeft niet uniform te zijn wat waarden betreft.
* samenstelling: user-defined data (discriminated union)

Syntax: [https://elm-lang.org/docs/syntax](https://elm-lang.org/docs/syntax)

## records

```
-- create records
origin = { x = 0, y = 0 }
point = { x = 3, y = 4 }

-- access fields
origin.x == 0
point.x == 3

-- field access function
List.map .x [ origin, point ] == [ 0, 3 ]

-- update a field
{ point | x = 6 } == { x = 6, y = 4 }

-- update many fields
{ point | x = point.x + 1, y = point.y + 1 }
```

Custom types

```
type User
  = Regular String Int
  | Visitor String
```

**OPMERKING** Ik begrijp nog niet helemaal waarom dit een "custom type" genoemd wordt, en bijv. een record niet.

In de terminologie van Hoare is dit een "disjoint union" type; waarbij een record een Cartesisch product is.

```
type alias Point = { x:Float, y:Float }
```

Je kunt, zonder een expliciet type te definiëren, een waarde maken als een Cartesisch product: `{x:12, y:"hi"}`. Deze waarde heeft (impliciet) een type. Door middel van een type-alias kun je dat type een naam geven.
(Type-gelijkheid is altijd gebaseerd op de structuur, niet op de naam. Dat heeft als voordeel dat je waarden kunt maken zonder dat je daarvoor een speciale constructor-functie hoeft te definiëren.)

Voor "disjoint union" is er niet zo'n constructie mogelijk, omdat je de "tags" voor de verschillende varianten eerst moet definiëren.


