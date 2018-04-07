   0 | struct b2TOIInput
   0 |   struct b2DistanceProxy proxyA
   0 |     struct b2Vec2 [2] m_buffer
  16 |     const struct b2Vec2 * m_vertices
  24 |     int32 m_count
  28 |     float32 m_radius
     |   [sizeof=32, dsize=32, align=8
     |    nvsize=32, nvalign=8]

  32 |   struct b2DistanceProxy proxyB
  32 |     struct b2Vec2 [2] m_buffer
  48 |     const struct b2Vec2 * m_vertices
  56 |     int32 m_count
  60 |     float32 m_radius
     |   [sizeof=32, dsize=32, align=8
     |    nvsize=32, nvalign=8]

  64 |   struct b2Sweep sweepA
  64 |     struct b2Vec2 localCenter
  64 |       float32 x
  68 |       float32 y
     |     [sizeof=8, dsize=8, align=4
     |      nvsize=8, nvalign=4]

  72 |     struct b2Vec2 c0
  72 |       float32 x
  76 |       float32 y
     |     [sizeof=8, dsize=8, align=4
     |      nvsize=8, nvalign=4]

  80 |     struct b2Vec2 c
  80 |       float32 x
  84 |       float32 y
     |     [sizeof=8, dsize=8, align=4
     |      nvsize=8, nvalign=4]

  88 |     float32 a0
  92 |     float32 a
  96 |     float32 alpha0
     |   [sizeof=36, dsize=36, align=4
     |    nvsize=36, nvalign=4]

 100 |   struct b2Sweep sweepB
 100 |     struct b2Vec2 localCenter
 100 |       float32 x
 104 |       float32 y
     |     [sizeof=8, dsize=8, align=4
     |      nvsize=8, nvalign=4]

 108 |     struct b2Vec2 c0
 108 |       float32 x
 112 |       float32 y
     |     [sizeof=8, dsize=8, align=4
     |      nvsize=8, nvalign=4]

 116 |     struct b2Vec2 c
 116 |       float32 x
 120 |       float32 y
     |     [sizeof=8, dsize=8, align=4
     |      nvsize=8, nvalign=4]

 124 |     float32 a0
 128 |     float32 a
 132 |     float32 alpha0
     |   [sizeof=36, dsize=36, align=4
     |    nvsize=36, nvalign=4]

 136 |   float32 tMax
     | [sizeof=144, dsize=140, align=8
     |  nvsize=140, nvalign=8]