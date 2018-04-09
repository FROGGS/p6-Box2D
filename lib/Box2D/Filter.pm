use v6;
use NativeCall;

#   0 | struct b2Filter
#   0 |   uint16 categoryBits
#   2 |   uint16 maskBits
#   4 |   int16 groupIndex
#     | [sizeof=6, dsize=6, align=2
#     |  nvsize=6, nvalign=2]
class Box2D::Filter is repr<CStruct> is export {
    method ^name($) { 'b2Filter' }
    has uint16 $.categoryBits;
    has uint16 $.maskBits;
    has int16 $.groupIndex;
}
