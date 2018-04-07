   0 | class b2Fixture
   0 |   float32 m_density
   8 |   class b2Fixture * m_next
  16 |   class b2Body * m_body
  24 |   class b2Shape * m_shape
  32 |   float32 m_friction
  36 |   float32 m_restitution
  40 |   struct b2FixtureProxy * m_proxies
  48 |   int32 m_proxyCount
  52 |   struct b2Filter m_filter
  52 |     uint16 categoryBits
  54 |     uint16 maskBits
  56 |     int16 groupIndex
     |   [sizeof=6, dsize=6, align=2
     |    nvsize=6, nvalign=2]

  58 |   _Bool m_isSensor
  64 |   void * m_userData
     | [sizeof=72, dsize=72, align=8
     |  nvsize=72, nvalign=8]