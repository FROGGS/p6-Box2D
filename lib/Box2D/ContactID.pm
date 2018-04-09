use v6;
use NativeCall;
use Box2D::ContactFeature;

#   0 | union b2ContactID
#   0 |   struct b2ContactFeature cf
#   0 |     uint8 indexA
#   1 |     uint8 indexB
#   2 |     uint8 typeA
#   3 |     uint8 typeB
#     |   [sizeof=4, dsize=4, align=1
#     |    nvsize=4, nvalign=1]
#
#   0 |   uint32 key
#     | [sizeof=4, dsize=4, align=4
#     |  nvsize=4, nvalign=4]
class Box2D::ContactID is repr<CUnion> is export {
    method ^name($) { 'b2ContactID' }
    HAS Box2D::ContactFeature $.cf;
    has uint32 $.key;
}
