use v6;
use NativeCall;
use Box2D::Vec2;
use Box2D::BlockAllocator;
use Box2D::StackAllocator;
use Box2D::TreeNode;
use Box2D::Pair;
use Box2D::Body;
use Box2D::ContactManager;
use Box2D::Profile;

#| The world class manages all physics entities, dynamic simulation,
#| and asynchronous queries. The world also contains efficient memory
#| management facilities.
class Box2D::World is repr<CPPStruct> is export {
    method ^name($) { 'b2World' }

#~ public:
    #| Construct a world object.
    #| @param gravity the world gravity vector.
    #method new(Box2D::Vec2 $gravity is cpp-ref is cpp-const) is native('Box2D') is nativeconv('thisgnu') { * }

    #~ /// Register a destruction listener. The listener is owned by you and must
    #~ /// remain in scope.
    #~ void SetDestructionListener(b2DestructionListener* listener);

    #~ /// Register a contact filter to provide specific control over collision.
    #~ /// Otherwise the default filter is used (b2_defaultFilter). The listener is
    #~ /// owned by you and must remain in scope.
    #~ void SetContactFilter(b2ContactFilter* filter);

    #~ /// Register a contact event listener. The listener is owned by you and must
    #~ /// remain in scope.
    #~ void SetContactListener(b2ContactListener* listener);

    #~ /// Register a routine for debug drawing. The debug draw functions are called
    #~ /// inside with b2World::DrawDebugData method. The debug draw object is owned
    #~ /// by you and must remain in scope.
    #~ void SetDebugDraw(b2Draw* debugDraw);

    #~ /// Create a rigid body given a definition. No reference to the definition
    #~ /// is retained.
    #~ /// @warning This function is locked during callbacks.
    #~ b2Body* CreateBody(const b2BodyDef* def);
    method CreateBody(Box2D::BodyDef is rw is cpp-const) returns Box2D::Body is native<Box2D> is nativeconv('thisgnu') { * }

    #~ /// Destroy a rigid body given a definition. No reference to the definition
    #~ /// is retained. This function is locked during callbacks.
    #~ /// @warning This automatically deletes all associated shapes and joints.
    #~ /// @warning This function is locked during callbacks.
    #~ void DestroyBody(b2Body* body);

    #~ /// Create a joint to constrain bodies together. No reference to the definition
    #~ /// is retained. This may cause the connected bodies to cease colliding.
    #~ /// @warning This function is locked during callbacks.
    #~ b2Joint* CreateJoint(const b2JointDef* def);

    #~ /// Destroy a joint. This may cause the connected bodies to begin colliding.
    #~ /// @warning This function is locked during callbacks.
    #~ void DestroyJoint(b2Joint* joint);

    #~ /// Take a time step. This performs collision detection, integration,
    #~ /// and constraint solution.
    #~ /// @param timeStep the amount of time to simulate, this should not vary.
    #~ /// @param velocityIterations for the velocity constraint solver.
    #~ /// @param positionIterations for the position constraint solver.
    #~ void Step(	float32 timeStep,
                #~ int32 velocityIterations,
                #~ int32 positionIterations);

    #~ /// Manually clear the force buffer on all bodies. By default, forces are cleared automatically
    #~ /// after each call to Step. The default behavior is modified by calling SetAutoClearForces.
    #~ /// The purpose of this function is to support sub-stepping. Sub-stepping is often used to maintain
    #~ /// a fixed sized time step under a variable frame-rate.
    #~ /// When you perform sub-stepping you will disable auto clearing of forces and instead call
    #~ /// ClearForces after all sub-steps are complete in one pass of your game loop.
    #~ /// @see SetAutoClearForces
    #~ void ClearForces();

    #~ /// Call this to draw shapes and other debug draw data. This is intentionally non-const.
    #~ void DrawDebugData();
    method draw-debug-data() is symbol<b2World::DrawDebugData> is native<Box2D> { * }

    #~ /// Query the world for all fixtures that potentially overlap the
    #~ /// provided AABB.
    #~ /// @param callback a user implemented callback class.
    #~ /// @param aabb the query box.
    #~ void QueryAABB(b2QueryCallback* callback, const b2AABB& aabb) const;

    #~ /// Ray-cast the world for all fixtures in the path of the ray. Your callback
    #~ /// controls whether you get the closest point, any point, or n-points.
    #~ /// The ray-cast ignores shapes that contain the starting point.
    #~ /// @param callback a user implemented callback class.
    #~ /// @param point1 the ray starting point
    #~ /// @param point2 the ray ending point
    #~ void RayCast(b2RayCastCallback* callback, const b2Vec2& point1, const b2Vec2& point2) const;

    #~ /// Get the world body list. With the returned body, use b2Body::GetNext to get
    #~ /// the next body in the world list. A NULL body indicates the end of the list.
    #~ /// @return the head of the world body list.
    #~ b2Body* GetBodyList();
    #~ const b2Body* GetBodyList() const;

    #~ /// Get the world joint list. With the returned joint, use b2Joint::GetNext to get
    #~ /// the next joint in the world list. A NULL joint indicates the end of the list.
    #~ /// @return the head of the world joint list.
    #~ b2Joint* GetJointList();
    #~ const b2Joint* GetJointList() const;

    #~ /// Get the world contact list. With the returned contact, use b2Contact::GetNext to get
    #~ /// the next contact in the world list. A NULL contact indicates the end of the list.
    #~ /// @return the head of the world contact list.
    #~ /// @warning contacts are created and destroyed in the middle of a time step.
    #~ /// Use b2ContactListener to avoid missing contacts.
    #~ b2Contact* GetContactList();
    #~ const b2Contact* GetContactList() const;

    #~ /// Enable/disable sleep.
    #~ void SetAllowSleeping(bool flag);
    #~ bool GetAllowSleeping() const { return m_allowSleep; }

    #~ /// Enable/disable warm starting. For testing.
    #~ void SetWarmStarting(bool flag) { m_warmStarting = flag; }
    #~ bool GetWarmStarting() const { return m_warmStarting; }

    #~ /// Enable/disable continuous physics. For testing.
    #~ void SetContinuousPhysics(bool flag) { m_continuousPhysics = flag; }
    #~ bool GetContinuousPhysics() const { return m_continuousPhysics; }

    #~ /// Enable/disable single stepped continuous physics. For testing.
    #~ void SetSubStepping(bool flag) { m_subStepping = flag; }
    #~ bool GetSubStepping() const { return m_subStepping; }

    #~ /// Get the number of broad-phase proxies.
    #~ int32 GetProxyCount() const;

    #~ /// Get the number of bodies.
    #~ int32 GetBodyCount() const;

    #~ /// Get the number of joints.
    #~ int32 GetJointCount() const;

    #~ /// Get the number of contacts (each may have 0 or more contact points).
    #~ int32 GetContactCount() const;

    #~ /// Get the height of the dynamic tree.
    #~ int32 GetTreeHeight() const;

    #~ /// Get the balance of the dynamic tree.
    #~ int32 GetTreeBalance() const;

    #~ /// Get the quality metric of the dynamic tree. The smaller the better.
    #~ /// The minimum is 1.
    #~ float32 GetTreeQuality() const;

    # /// Change the global gravity vector.
    # void SetGravity(const b2Vec2& gravity);
    method SetGravity(Box2D::Vec2 $gravity) {
        $!m_gravity.Set($gravity.x, $gravity.y); # ))
    }

    # /// Get the global gravity vector.
    # b2Vec2 GetGravity() const;
    method GetGravity() { $!m_gravity }

    #~ /// Is the world locked (in the middle of a time step).
    #~ bool IsLocked() const;

    #~ /// Set flag to control automatic clearing of forces after each time step.
    #~ void SetAutoClearForces(bool flag);

    #~ /// Get the flag that controls automatic clearing of forces after each time step.
    #~ bool GetAutoClearForces() const;

    #~ /// Shift the world origin. Useful for large worlds.
    #~ /// The body shift formula is: position -= newOrigin
    #~ /// @param newOrigin the new origin with respect to the old origin
    #~ void ShiftOrigin(const b2Vec2& newOrigin);

    #~ /// Get the contact manager for testing.
    #~ const b2ContactManager& GetContactManager() const;

    #~ /// Get the current profile.
    #~ const b2Profile& GetProfile() const;

    #~ /// Dump the world into the log file.
    #~ /// @warning this should be called outside of a time step.
    method dump() is symbol<b2World::Dump> is native<Box2D> { * }

#~ private:

    #~ // m_flags
    #~ enum
    #~ {
        #~ e_newFixture	= 0x0001,
        #~ e_locked		= 0x0002,
        #~ e_clearForces	= 0x0004
    #~ };

    #~ friend class b2Body;
    #~ friend class b2Fixture;
    #~ friend class b2ContactManager;
    #~ friend class b2Controller;

    #~ void Solve(const b2TimeStep& step);
    #~ void SolveTOI(const b2TimeStep& step);

    #~ void DrawJoint(b2Joint* joint);
    #~ void DrawShape(b2Fixture* shape, const b2Transform& xf, const b2Color& color);

    HAS Box2D::BlockAllocator $.m_blockAllocator;
    HAS Box2D::StackAllocator $.m_stackAllocator;

    has int32 $.m_flags;

    HAS Box2D::ContactManager $.m_contactManager;

    #~ b2Body* m_bodyList;
    has CArray[Box2D::Body] $.m_bodyList;
    #~ b2Joint* m_jointList;
    has Pointer $.m_jointList;

    has int32 $.m_bodyCount;
    has int32 $.m_jointCount;

    HAS Box2D::Vec2 $.m_gravity;
    has int8 $.m_allowSleep;

    #~ b2DestructionListener* m_destructionListener;
    has Pointer $.m_destructionListener;
    #~ b2Draw* g_debugDraw;
    has Pointer $.g_debugDraw;

    #| This is used to compute the time step ratio to
    #| support a variable time step.
    has num32 $.m_inv_dt0;

    #~ These are for debugging the solver.
    has int8 $.m_warmStarting;
    has int8 $.m_continuousPhysics;
    has int8 $.m_subStepping;

    has int8 $.m_stepComplete;

    HAS Box2D::Profile $.m_profile;

    submethod BUILD(
        :$gravity,
    ) {
        use nqp;
        $!m_gravity := nqp::decont($gravity // Box2D::Vec2.new(0e0, -10e0));
    }
}
