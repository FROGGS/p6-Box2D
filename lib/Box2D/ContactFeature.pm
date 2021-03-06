use v6;
use NativeCall;

#   0 | struct b2ContactFeature
#   0 |   uint8 indexA
#   1 |   uint8 indexB
#   2 |   uint8 typeA
#   3 |   uint8 typeB
#     | [sizeof=4, dsize=4, align=1
#     |  nvsize=4, nvalign=1]
class Box2D::ContactFeature is repr<CStruct> is export {
    method ^name($) { 'b2ContactFeature' }
    has uint8 $.indexA;
    has uint8 $.indexB;
    has uint8 $.typeA;
    has uint8 $.typeB;
}
