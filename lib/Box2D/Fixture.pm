use v6;
use NativeCall;
use Box2D::Filter;
use Box2D::Shape;

class Box2D::FixtureDef is repr<CStruct> is export {
    method ^name($) { 'b2FixtureDef' }

    #| The shape, this must be set. The shape will be cloned, so you
    #| can create the shape on the stack.
    has Box2D::Shape $.shape is rw;
    #has Pointer $.shape_vmt is rw;
    #has uint8 $.shape_m_type is rw;
    #has num32 $.shape_m_radius is rw;

    #| Use this to store application specific fixture data.
    has Pointer $.userData;

    #| The friction coefficient, usually in the range [0,1].
    has num32 $.friction is rw;

    #| The restitution (elasticity) usually in the range [0,1].
    has num32 $.restitution is rw;

    #| The density, usually in kg/m^2.
    has num32 $.density is rw;

    #| A sensor shape collects contact information but never generates a collision
    #| response.
    has bool $.isSensor;

    #| Contact filtering data.
    #HAS Box2D::Filter $.filter;
    has uint16 $.filter_categoryBits is rw;
    has uint16 $.filter_maskBits is rw;
    has int16 $.filter_groupIndex is rw;

    #| The constructor sets the default fixture definition values.
    submethod BUILD(
        :$shape,
        :$friction,
        :$restitution,
        :$density,
        :$isSensor,
    ) {
        #b2FixtureDef()
        #{
        #    shape = nullptr;
        #    userData = nullptr;
        #    friction = 0.2f;
        #    restitution = 0.0f;
        #    density = 0.0f;
        #    isSensor = false;
        #}

        use nqp;
        $!shape         := nqp::decont($shape // Box2D::Shape);
        #$!shape.m_type   = $shape ?? $shape.m_type   !! 0;
        #$!shape.m_radius = $shape ?? $shape.m_radius !! 0;
        #$!shape_m_type   = $shape ?? $shape.m_type   !! 0;
        #$!shape_m_radius = $shape ?? $shape.m_radius !! 0e0;

        $!friction    = $friction    // 0.2e0;
        $!restitution = $restitution // 0e0;
        $!density     = $density     // 0e0;
        $!isSensor    = $isSensor    // False;

        #b2Filter()
        #{
        #    categoryBits = 0x0001;
        #    maskBits = 0xFFFF;
        #    groupIndex = 0;
        #}
        $!filter_categoryBits = 0x0001;
        $!filter_maskBits     = 0xFFFF;
        $!filter_groupIndex   = 0;
    }
}

#   0 | class b2Fixture
#   0 |   float32 m_density
#   8 |   class b2Fixture * m_next
#  16 |   class b2Body * m_body
#  24 |   class b2Shape * m_shape
#  32 |   float32 m_friction
#  36 |   float32 m_restitution
#  40 |   struct b2FixtureProxy * m_proxies
#  48 |   int32 m_proxyCount
#  52 |   struct b2Filter m_filter
#  52 |     uint16 categoryBits
#  54 |     uint16 maskBits
#  56 |     int16 groupIndex
#     |   [sizeof=6, dsize=6, align=2
#     |    nvsize=6, nvalign=2]
#
#  58 |   _Bool m_isSensor
#  64 |   void * m_userData
#     | [sizeof=72, dsize=72, align=8
#     |  nvsize=72, nvalign=8]
class Box2D::Fixture is repr<CStruct> is export {
    method ^name($) { 'b2Fixture' }
    has num32 $.m_density;
    has Box2D::Fixture $.m_next;
    #has Box2D::Body $.m_body;
    has Pointer $.m_body;
    #has Box2D::Shape $.m_shape;
    has Pointer $.m_shape;
    has num32 $.m_friction;
    has num32 $.m_restitution;
    #has Box2D::FixtureProxy $.m_proxies;
    has Pointer $.m_proxies;
    has int32 $.m_proxyCount;
    HAS Box2D::Filter $.m_filter;
    has bool $.m_isSensor;
    has Pointer $.m_userData;
}


