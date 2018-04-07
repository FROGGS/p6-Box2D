use v6;
use NativeCall;
use Box2D::Vec2;
use Box2D::Sweep;
use Box2D::Transform;

enum b2BodyType <staticBody kinematicBody dynamicBody>;

class Box2D::BodyDef is repr<CStruct> is export {
    method ^name($) { 'b2BodyDef' }

    #| The body type: static, kinematic, or dynamic.
    #| Note: if a dynamic body would have zero mass, the mass is set to one.
    has int32 $.type is rw; # b2BodyType

    #| The world position of the body. Avoid creating bodies at the origin
    #| since this can lead to many overlapping shapes.
    HAS Box2D::Vec2 $.position;

    #| The world angle of the body in radians.
    has num32 $.angle is rw;

    #| The linear velocity of the body's origin in world co-ordinates.
    #~ has b2Vec2 linearVelocity;
    HAS Box2D::Vec2 $.linearVelocity;
    #~ has num32 $.linearVelocity_x;
    #~ has num32 $.linearVelocity_y;

    #| The angular velocity of the body.
    has num32 $.angularVelocity is rw;

    #| Linear damping is use to reduce the linear velocity. The damping parameter
    #| can be larger than 1.0f but the damping effect becomes sensitive to the
    #| time step when the damping parameter is large.
    has num32 $.linearDamping is rw;

    #| Angular damping is use to reduce the angular velocity. The damping parameter
    #| can be larger than 1.0f but the damping effect becomes sensitive to the
    #| time step when the damping parameter is large.
    has num32 $.angularDamping is rw;

    #| Set this flag to false if this body should never fall asleep. Note that
    #| this increases CPU usage.
    has int8 $.allowSleep is rw;

    #| Is this body initially awake or sleeping?
    has int8 $.awake is rw;

    #| Should this body be prevented from rotating? Useful for characters.
    has int8 $.fixedRotation is rw;

    #| Is this a fast moving body that should be prevented from tunneling through
    #| other moving bodies? Note that all bodies are prevented from tunneling through
    #| kinematic and static bodies. This setting is only considered on dynamic bodies.
    #| @warning You should use this flag sparingly since it increases processing time.
    has int8 $.bullet is rw;

    #| Does this body start out active?
    has int8 $.active is rw;

    #| Use this to store application specific body data.
    has Pointer $.userData is rw;

    #| Scale the gravity applied to this body.
    has num32 $.gravityScale is rw;

    #| This constructor sets the body definition default values.
    submethod BUILD(
        :$type,
        :$position,
        :$angle,
        :$linearVelocity,
        :$angularVelocity,
        :$linearDamping,
        :$angularDamping,
        :$allowSleep,
        :$awake,
        :$fixedRotation,
        :$bullet,
        :$active,
        :$gravityScale
    ) {

        $!type             = $type            // staticBody;
        $!position        := $position        // Box2D::Vec2.new(0e0, 0e0);
        $!angle            = $angle           // 0e0;
        $!linearVelocity  := $linearVelocity  // Box2D::Vec2.new(0e0, 0e0);
        $!angularVelocity  = $angularVelocity // 0e0;
        $!linearDamping    = $linearDamping   // 0e0;
        $!angularDamping   = $angularDamping  // 0e0;
        $!allowSleep       = $allowSleep      // 1;
        $!awake            = $awake           // 1;
        $!fixedRotation    = $fixedRotation   // 0;
        $!bullet           = $bullet          // 0;
        $!active           = $active          // 1;
        $!gravityScale     = $gravityScale    // 1e0;
    }
};

class Box2D::Body is repr<CStruct> is export {
    method ^name($) { 'b2Body' }

    has uint32 $.m_type;
    has uint16 $.m_flags;
    has int32  $.m_islandIndex;
    HAS Box2D::Transform $.m_xf;
    HAS Box2D::Sweep $.m_sweep;
    HAS Box2D::Vec2 $.m_linearVelocity;
    has num32 $.m_angularVelocity;
    HAS Box2D::Vec2 $.m_force;
    has num32 $.m_torque;
    has Pointer $.m_world;
    has Box2D::Body $.m_prev;
    has Box2D::Body $.m_next;
    has Pointer $.m_fixtureList;
    has int32 $.m_fixtureCount;
    has Pointer $.m_jointList;
    has Pointer $.m_contactList;
    has num32 $.m_mass;
    has num32 $.m_invMass;
    has num32 $.m_I;
    has num32 $.m_invI;
    has num32 $.m_linearDamping;
    has num32 $.m_angularDamping;
    has num32 $.m_gravityScale;
    has num32 $.m_sleepTime;
    has Pointer $.m_userData;
}

   #~ 0 | class b2Body
   #~ 0 |   enum b2BodyType m_type
   #~ 4 |   uint16 m_flags
   #~ 8 |   int32 m_islandIndex
  #~ 12 |   struct b2Transform m_xf
  #~ 12 |     struct b2Vec2 p
  #~ 12 |       float32 x
  #~ 16 |       float32 y
     #~ |     [sizeof=8, dsize=8, align=4
     #~ |      nvsize=8, nvalign=4]

  #~ 20 |     struct b2Rot q
  #~ 20 |       float32 s
  #~ 24 |       float32 c
     #~ |     [sizeof=8, dsize=8, align=4
     #~ |      nvsize=8, nvalign=4]

     #~ |   [sizeof=16, dsize=16, align=4
     #~ |    nvsize=16, nvalign=4]

  #~ 28 |   struct b2Sweep m_sweep
  #~ 28 |     struct b2Vec2 localCenter
  #~ 28 |       float32 x
  #~ 32 |       float32 y
     #~ |     [sizeof=8, dsize=8, align=4
     #~ |      nvsize=8, nvalign=4]

  #~ 36 |     struct b2Vec2 c0
  #~ 36 |       float32 x
  #~ 40 |       float32 y
     #~ |     [sizeof=8, dsize=8, align=4
     #~ |      nvsize=8, nvalign=4]

  #~ 44 |     struct b2Vec2 c
  #~ 44 |       float32 x
  #~ 48 |       float32 y
     #~ |     [sizeof=8, dsize=8, align=4
     #~ |      nvsize=8, nvalign=4]

  #~ 52 |     float32 a0
  #~ 56 |     float32 a
  #~ 60 |     float32 alpha0
     #~ |   [sizeof=36, dsize=36, align=4
     #~ |    nvsize=36, nvalign=4]

  #~ 64 |   struct b2Vec2 m_linearVelocity
  #~ 64 |     float32 x
  #~ 68 |     float32 y
     #~ |   [sizeof=8, dsize=8, align=4
     #~ |    nvsize=8, nvalign=4]

  #~ 72 |   float32 m_angularVelocity
  #~ 76 |   struct b2Vec2 m_force
  #~ 76 |     float32 x
  #~ 80 |     float32 y
     #~ |   [sizeof=8, dsize=8, align=4
     #~ |    nvsize=8, nvalign=4]

  #~ 84 |   float32 m_torque
  #~ 88 |   class b2World * m_world
  #~ 96 |   class b2Body * m_prev
 #~ 104 |   class b2Body * m_next
 #~ 112 |   class b2Fixture * m_fixtureList
 #~ 120 |   int32 m_fixtureCount
 #~ 128 |   struct b2JointEdge * m_jointList
 #~ 136 |   struct b2ContactEdge * m_contactList
 #~ 144 |   float32 m_mass
 #~ 148 |   float32 m_invMass
 #~ 152 |   float32 m_I
 #~ 156 |   float32 m_invI
 #~ 160 |   float32 m_linearDamping
 #~ 164 |   float32 m_angularDamping
 #~ 168 |   float32 m_gravityScale
 #~ 172 |   float32 m_sleepTime
 #~ 176 |   void * m_userData
     #~ | [sizeof=184, dsize=184, align=8
     #~ |  nvsize=184, nvalign=8]
