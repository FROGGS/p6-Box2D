use v6;
use NativeCall;

#   0 | struct b2Rot
#   0 |   float32 s
#   4 |   float32 c
#     | [sizeof=8, dsize=8, align=4
#     |  nvsize=8, nvalign=4]

class Box2D::Rot is repr<CStruct> is export {
    method ^name($) { 'b2Rot' }

    has num32 $.s;
    has num32 $.c;
}
