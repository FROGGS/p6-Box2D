use v6;
use NativeCall;
use Box2D::TreeNode;

#| A dynamic AABB tree broad-phase, inspired by Nathanael Presson's btDbvt.
#| A dynamic tree arranges data in a binary tree to accelerate
#| queries such as volume queries and ray casts. Leafs are proxies
#| with an AABB. In the tree we expand the proxy AABB by b2_fatAABBFactor
#| so that the proxy AABB is bigger than the client object. This allows the client
#| object to move by small amounts without triggering a tree update.
#|
#| Nodes are pooled and relocatable, so we use node indices rather than pointers.
class Box2D::DynamicTree is repr<CPPStruct> is export {
    method ^name($) { 'b2DynamicTree' }
#~ public:
    #~ /// Constructing the tree initializes the node pool.
    #~ b2DynamicTree();

    #~ /// Destroy the tree, freeing the node pool.
    #~ ~b2DynamicTree();

    #~ /// Create a proxy. Provide a tight fitting AABB and a userData pointer.
    #~ int32 CreateProxy(const b2AABB& aabb, void* userData);

    #~ /// Destroy a proxy. This asserts if the id is invalid.
    #~ void DestroyProxy(int32 proxyId);

    #~ /// Move a proxy with a swepted AABB. If the proxy has moved outside of its fattened AABB,
    #~ /// then the proxy is removed from the tree and re-inserted. Otherwise
    #~ /// the function returns immediately.
    #~ /// @return true if the proxy was re-inserted.
    #~ bool MoveProxy(int32 proxyId, const b2AABB& aabb1, const b2Vec2& displacement);

    #~ /// Get proxy user data.
    #~ /// @return the proxy user data or 0 if the id is invalid.
    #~ void* GetUserData(int32 proxyId) const;

    #~ /// Get the fat AABB for a proxy.
    #~ const b2AABB& GetFatAABB(int32 proxyId) const;

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

    #~ /// Validate this tree. For testing.
    #~ void Validate() const;

    #~ /// Compute the height of the binary tree in O(N) time. Should not be
    #~ /// called often.
    #~ int32 GetHeight() const;

    #~ /// Get the maximum balance of an node in the tree. The balance is the difference
    #~ /// in height of the two children of a node.
    #~ int32 GetMaxBalance() const;

    #~ /// Get the ratio of the sum of the node areas to the root area.
    #~ float32 GetAreaRatio() const;

    #~ /// Build an optimal tree. Very expensive. For testing.
    #~ void RebuildBottomUp();

    #~ /// Shift the world origin. Useful for large worlds.
    #~ /// The shift formula is: position -= newOrigin
    #~ /// @param newOrigin the new origin with respect to the old origin
    #~ void ShiftOrigin(const b2Vec2& newOrigin);

#~ private:

    #~ int32 AllocateNode();
    #~ void FreeNode(int32 node);

    #~ void InsertLeaf(int32 node);
    #~ void RemoveLeaf(int32 node);

    #~ int32 Balance(int32 index);

    #~ int32 ComputeHeight() const;
    #~ int32 ComputeHeight(int32 nodeId) const;

    #~ void ValidateStructure(int32 index) const;
    #~ void ValidateMetrics(int32 index) const;

    has int32 $.m_root;

    has Box2D::TreeNode $.m_nodes;
    has int32 $.m_nodeCount;
    has int32 $.m_nodeCapacity;

    has int32 $.m_freeList;

    #| This is used to incrementally traverse the tree for re-balancing.
    has uint32 $.m_path;

    has int32 $.m_insertionCount;
}
