   0 | struct b2ClipVertex
   0 |   struct b2Vec2 v
   0 |     float32 x
   4 |     float32 y
     |   [sizeof=8, dsize=8, align=4
     |    nvsize=8, nvalign=4]

   8 |   union b2ContactID id
   8 |     struct b2ContactFeature cf
   8 |       uint8 indexA
   9 |       uint8 indexB
  10 |       uint8 typeA
  11 |       uint8 typeB
     |     [sizeof=4, dsize=4, align=1
     |      nvsize=4, nvalign=1]

   8 |     uint32 key
     |   [sizeof=4, dsize=4, align=4
     |    nvsize=4, nvalign=4]

     | [sizeof=12, dsize=12, align=4
     |  nvsize=12, nvalign=4]