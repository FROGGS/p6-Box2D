   0 | struct b2ManifoldPoint
   0 |   struct b2Vec2 localPoint
   0 |     float32 x
   4 |     float32 y
     |   [sizeof=8, dsize=8, align=4
     |    nvsize=8, nvalign=4]

   8 |   float32 normalImpulse
  12 |   float32 tangentImpulse
  16 |   union b2ContactID id
  16 |     struct b2ContactFeature cf
  16 |       uint8 indexA
  17 |       uint8 indexB
  18 |       uint8 typeA
  19 |       uint8 typeB
     |     [sizeof=4, dsize=4, align=1
     |      nvsize=4, nvalign=1]

  16 |     uint32 key
     |   [sizeof=4, dsize=4, align=4
     |    nvsize=4, nvalign=4]

     | [sizeof=20, dsize=20, align=4
     |  nvsize=20, nvalign=4]