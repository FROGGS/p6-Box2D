use v6;
use NativeCall;
use Box2D::Vec2;
use Box2D::Sweep;
use Box2D::Transform;
use Box2D::Fixture;
use Box2D::Shape;
use Box2D::PolygonShape;

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
    HAS Box2D::Vec2 $.linearVelocity;

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

class Box2D::Body is repr<CPPStruct> is export {
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

#public:
#	/// Creates a fixture and attach it to this body. Use this function if you need
#	/// to set some fixture parameters, like friction. Otherwise you can create the
#	/// fixture directly from a shape.
#	/// If the density is non-zero, this function automatically updates the mass of the body.
#	/// Contacts are not created until the next time step.
#	/// @param def the fixture definition.
#	/// @warning This function is locked during callbacks.
    # b2Fixture* CreateFixture(const b2FixtureDef* def);
    #multi method CreateFixture(Box2D::FixtureDef is cpp-const) returns Box2D::Fixture is native<Box2D> { * }

#	/// Creates a fixture from a shape and attach it to this body.
#	/// This is a convenience function. Use b2FixtureDef if you need to set parameters
#	/// like friction, restitution, user data, or filtering.
#	/// If the density is non-zero, this function automatically updates the mass of the body.
#	/// @param shape the shape to be cloned.
#	/// @param density the shape density (set to zero for static bodies).
#	/// @warning This function is locked during callbacks.
#	b2Fixture* CreateFixture(const b2Shape* shape, float32 density);
    method !CreateFixture(Box2D::Shape $shape is cpp-const is rw, num32 $density) returns Box2D::Fixture is native<Box2D> { * }
    method CreateFixture(Box2D::PolygonShape $shape, $density) {
        self!CreateFixture($shape, $density.Num);
    }

#	/// Destroy a fixture. This removes the fixture from the broad-phase and
#	/// destroys all contacts associated with this fixture. This will
#	/// automatically adjust the mass of the body if the body is dynamic and the
#	/// fixture has positive density.
#	/// All fixtures attached to a body are implicitly destroyed when the body is destroyed.
#	/// @param fixture the fixture to be removed.
#	/// @warning This function is locked during callbacks.
#	void DestroyFixture(b2Fixture* fixture);
#
#	/// Set the position of the body's origin and rotation.
#	/// Manipulating a body's transform may cause non-physical behavior.
#	/// Note: contacts are updated on the next call to b2World::Step.
#	/// @param position the world position of the body's local origin.
#	/// @param angle the world rotation in radians.
#	void SetTransform(const b2Vec2& position, float32 angle);
#
#	/// Get the body transform for the body's origin.
#	/// @return the world transform of the body's origin.
#	const b2Transform& GetTransform() const;
#
#	/// Get the world body origin position.
#	/// @return the world position of the body's origin.
#	const b2Vec2& GetPosition() const;
#
#	/// Get the angle in radians.
#	/// @return the current world rotation angle in radians.
#	float32 GetAngle() const;
#
#	/// Get the world position of the center of mass.
#	const b2Vec2& GetWorldCenter() const;
#
#	/// Get the local position of the center of mass.
#	const b2Vec2& GetLocalCenter() const;
#
#	/// Set the linear velocity of the center of mass.
#	/// @param v the new linear velocity of the center of mass.
#	void SetLinearVelocity(const b2Vec2& v);
#
#	/// Get the linear velocity of the center of mass.
#	/// @return the linear velocity of the center of mass.
#	const b2Vec2& GetLinearVelocity() const;
#
#	/// Set the angular velocity.
#	/// @param omega the new angular velocity in radians/second.
#	void SetAngularVelocity(float32 omega);
#
#	/// Get the angular velocity.
#	/// @return the angular velocity in radians/second.
#	float32 GetAngularVelocity() const;
#
#	/// Apply a force at a world point. If the force is not
#	/// applied at the center of mass, it will generate a torque and
#	/// affect the angular velocity. This wakes up the body.
#	/// @param force the world force vector, usually in Newtons (N).
#	/// @param point the world position of the point of application.
#	/// @param wake also wake up the body
#	void ApplyForce(const b2Vec2& force, const b2Vec2& point, bool wake);
#
#	/// Apply a force to the center of mass. This wakes up the body.
#	/// @param force the world force vector, usually in Newtons (N).
#	/// @param wake also wake up the body
#	void ApplyForceToCenter(const b2Vec2& force, bool wake);
#
#	/// Apply a torque. This affects the angular velocity
#	/// without affecting the linear velocity of the center of mass.
#	/// This wakes up the body.
#	/// @param torque about the z-axis (out of the screen), usually in N-m.
#	/// @param wake also wake up the body
#	void ApplyTorque(float32 torque, bool wake);
#
#	/// Apply an impulse at a point. This immediately modifies the velocity.
#	/// It also modifies the angular velocity if the point of application
#	/// is not at the center of mass. This wakes up the body.
#	/// @param impulse the world impulse vector, usually in N-seconds or kg-m/s.
#	/// @param point the world position of the point of application.
#	/// @param wake also wake up the body
#	void ApplyLinearImpulse(const b2Vec2& impulse, const b2Vec2& point, bool wake);
#
#	/// Apply an angular impulse.
#	/// @param impulse the angular impulse in units of kg*m*m/s
#	/// @param wake also wake up the body
#	void ApplyAngularImpulse(float32 impulse, bool wake);
#
#	/// Get the total mass of the body.
#	/// @return the mass, usually in kilograms (kg).
#	float32 GetMass() const;
#
#	/// Get the rotational inertia of the body about the local origin.
#	/// @return the rotational inertia, usually in kg-m^2.
#	float32 GetInertia() const;
#
#	/// Get the mass data of the body.
#	/// @return a struct containing the mass, inertia and center of the body.
#	void GetMassData(b2MassData* data) const;
#
#	/// Set the mass properties to override the mass properties of the fixtures.
#	/// Note that this changes the center of mass position.
#	/// Note that creating or destroying fixtures can also alter the mass.
#	/// This function has no effect if the body isn't dynamic.
#	/// @param massData the mass properties.
#	void SetMassData(const b2MassData* data);
#
#	/// This resets the mass properties to the sum of the mass properties of the fixtures.
#	/// This normally does not need to be called unless you called SetMassData to override
#	/// the mass and you later want to reset the mass.
#	void ResetMassData();
#
#	/// Get the world coordinates of a point given the local coordinates.
#	/// @param localPoint a point on the body measured relative the the body's origin.
#	/// @return the same point expressed in world coordinates.
#	b2Vec2 GetWorldPoint(const b2Vec2& localPoint) const;
#
#	/// Get the world coordinates of a vector given the local coordinates.
#	/// @param localVector a vector fixed in the body.
#	/// @return the same vector expressed in world coordinates.
#	b2Vec2 GetWorldVector(const b2Vec2& localVector) const;
#
#	/// Gets a local point relative to the body's origin given a world point.
#	/// @param a point in world coordinates.
#	/// @return the corresponding local point relative to the body's origin.
#	b2Vec2 GetLocalPoint(const b2Vec2& worldPoint) const;
#
#	/// Gets a local vector given a world vector.
#	/// @param a vector in world coordinates.
#	/// @return the corresponding local vector.
#	b2Vec2 GetLocalVector(const b2Vec2& worldVector) const;
#
#	/// Get the world linear velocity of a world point attached to this body.
#	/// @param a point in world coordinates.
#	/// @return the world velocity of a point.
#	b2Vec2 GetLinearVelocityFromWorldPoint(const b2Vec2& worldPoint) const;
#
#	/// Get the world velocity of a local point.
#	/// @param a point in local coordinates.
#	/// @return the world velocity of a point.
#	b2Vec2 GetLinearVelocityFromLocalPoint(const b2Vec2& localPoint) const;
#
#	/// Get the linear damping of the body.
#	float32 GetLinearDamping() const;
#
#	/// Set the linear damping of the body.
#	void SetLinearDamping(float32 linearDamping);
#
#	/// Get the angular damping of the body.
#	float32 GetAngularDamping() const;
#
#	/// Set the angular damping of the body.
#	void SetAngularDamping(float32 angularDamping);
#
#	/// Get the gravity scale of the body.
#	float32 GetGravityScale() const;
#
#	/// Set the gravity scale of the body.
#	void SetGravityScale(float32 scale);
#
#	/// Set the type of this body. This may alter the mass and velocity.
#	void SetType(b2BodyType type);
#
#	/// Get the type of this body.
#	b2BodyType GetType() const;
#
#	/// Should this body be treated like a bullet for continuous collision detection?
#	void SetBullet(bool flag);
#
#	/// Is this body treated like a bullet for continuous collision detection?
#	bool IsBullet() const;
#
#	/// You can disable sleeping on this body. If you disable sleeping, the
#	/// body will be woken.
#	void SetSleepingAllowed(bool flag);
#
#	/// Is this body allowed to sleep
#	bool IsSleepingAllowed() const;
#
#	/// Set the sleep state of the body. A sleeping body has very
#	/// low CPU cost.
#	/// @param flag set to true to wake the body, false to put it to sleep.
#	void SetAwake(bool flag);
#
#	/// Get the sleeping state of this body.
#	/// @return true if the body is awake.
#	bool IsAwake() const;
#
#	/// Set the active state of the body. An inactive body is not
#	/// simulated and cannot be collided with or woken up.
#	/// If you pass a flag of true, all fixtures will be added to the
#	/// broad-phase.
#	/// If you pass a flag of false, all fixtures will be removed from
#	/// the broad-phase and all contacts will be destroyed.
#	/// Fixtures and joints are otherwise unaffected. You may continue
#	/// to create/destroy fixtures and joints on inactive bodies.
#	/// Fixtures on an inactive body are implicitly inactive and will
#	/// not participate in collisions, ray-casts, or queries.
#	/// Joints connected to an inactive body are implicitly inactive.
#	/// An inactive body is still owned by a b2World object and remains
#	/// in the body list.
#	void SetActive(bool flag);
#
#	/// Get the active state of the body.
#	bool IsActive() const;
#
#	/// Set this body to have fixed rotation. This causes the mass
#	/// to be reset.
#	void SetFixedRotation(bool flag);
#
#	/// Does this body have fixed rotation?
#	bool IsFixedRotation() const;
#
#	/// Get the list of all fixtures attached to this body.
#	b2Fixture* GetFixtureList();
#	const b2Fixture* GetFixtureList() const;
#
#	/// Get the list of all joints attached to this body.
#	b2JointEdge* GetJointList();
#	const b2JointEdge* GetJointList() const;
#
#	/// Get the list of all contacts attached to this body.
#	/// @warning this list changes during the time step and you may
#	/// miss some collisions if you don't use b2ContactListener.
#	b2ContactEdge* GetContactList();
#	const b2ContactEdge* GetContactList() const;
#
#	/// Get the next body in the world's body list.
#	b2Body* GetNext();
#	const b2Body* GetNext() const;
#
#	/// Get the user data pointer that was provided in the body definition.
#	void* GetUserData() const;
#
#	/// Set the user data. Use this to store your application specific data.
#	void SetUserData(void* data);
#
#	/// Get the parent world of this body.
#	b2World* GetWorld();
#	const b2World* GetWorld() const;
#
#	/// Dump this body to a log file
#	void Dump();
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
