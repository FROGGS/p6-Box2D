use v6;
use NativeCall;
use Box2D::AABB;

#| A node in the dynamic tree. The client does not interact with this directly.
class Box2D::TreeNode is repr<CPPStruct> is export {
    method ^name($) { 'b2TreeNode' }

    #~ bool IsLeaf() const
    #~ {
        #~ return child1 == b2_nullNode;
    #~ }

    #| Enlarged AABB
    HAS Box2D::AABB $.aabb;

    has Pointer $.userData;

    #~ union
    #~ {
        #~ int32 parent;
        #~ int32 next;
    #~ };
    has int32 $.parent;

    has int32 $.child1;
    has int32 $.child2;

    #| leaf = 0, free node = -1
    has int32 $.height;
}
