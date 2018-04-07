use v6;
use NativeCall;
use Box2D::Pair;
use Box2D::TreeNode;
use Box2D::DynamicTree;

class Box2D::BroadPhase is repr<CPPStruct> is export {
    method ^name($) { 'b2BroadPhase' }

#~ public:

    #~ enum
    #~ {
        #~ e_nullProxy = -1
    #~ };

    #~ b2BroadPhase();
    #~ ~b2BroadPhase();

    #~ /// Create a proxy with an initial AABB. Pairs are not reported until
    #~ /// UpdatePairs is called.
    #~ int32 CreateProxy(const b2AABB& aabb, void* userData);

    #~ /// Destroy a proxy. It is up to the client to remove any pairs.
    #~ void DestroyProxy(int32 proxyId);

    #~ /// Call MoveProxy as many times as you like, then when you are done
    #~ /// call UpdatePairs to finalized the proxy pairs (for your time step).
    #~ void MoveProxy(int32 proxyId, const b2AABB& aabb, const b2Vec2& displacement);

    #~ /// Call to trigger a re-processing of it's pairs on the next call to UpdatePairs.
    #~ void TouchProxy(int32 proxyId);

    #~ /// Get the fat AABB for a proxy.
    #~ const b2AABB& GetFatAABB(int32 proxyId) const;

    #~ /// Get user data from a proxy. Returns NULL if the id is invalid.
    #~ void* GetUserData(int32 proxyId) const;

    #~ /// Test overlap of fat AABBs.
    #~ bool TestOverlap(int32 proxyIdA, int32 proxyIdB) const;

    #~ /// Get the number of proxies.
    #~ int32 GetProxyCount() const;

    #~ /// Update the pairs. This results in pair callbacks. This can only add pairs.
    #~ template <typename T>
    #~ void UpdatePairs(T* callback);

    #~ /// Query an AABB for overlapping proxies. The callback class
    #~ /// is called for each proxy that overlaps the supplied AABB.
    #~ template <typename T>
    #~ void Query(T* callback, const b2AABB& aabb) const;

    #~ /// Ray-cast against the proxies in the tree. This relies on the callback
    #~ /// to perform a exact ray-cast in the case were the proxy contains a shape.
    #~ /// The callback also performs the any collision filtering. This has performance
    #~ /// roughly equal to k * log(n), where k is the number of collisions and n is the
    #~ /// number of proxies in the tree.
    #~ /// @param input the ray-cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1).
    #~ /// @param callback a callback class that is called for each proxy that is hit by the ray.
    #~ template <typename T>
    #~ void RayCast(T* callback, const b2RayCastInput& input) const;

    #~ /// Get the height of the embedded tree.
    #~ int32 GetTreeHeight() const;

    #~ /// Get the balance of the embedded tree.
    #~ int32 GetTreeBalance() const;

    #~ /// Get the quality metric of the embedded tree.
    #~ float32 GetTreeQuality() const;

    #~ /// Shift the world origin. Useful for large worlds.
    #~ /// The shift formula is: position -= newOrigin
    #~ /// @param newOrigin the new origin with respect to the old origin
    #~ void ShiftOrigin(const b2Vec2& newOrigin);

#~ private:

    #~ friend class b2DynamicTree;

    #~ void BufferMove(int32 proxyId);
    #~ void UnBufferMove(int32 proxyId);

    #~ bool QueryCallback(int32 proxyId);

    has Pointer $.VirtualMethodTable; # ???

    HAS Box2D::DynamicTree $.m_tree;
    has int32              $.m_proxyCount;
    has int32              $.m_moveBuffer is rw;
    has int32              $.m_moveCapacity;
    has int32              $.m_moveCount;
    has Box2D::Pair        $.m_pairBuffer;
    has int32              $.m_pairCapacity;
    has int32              $.m_pairCount;
    has int32              $.m_queryProxyId;
}
