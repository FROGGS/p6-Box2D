use v6;
use NativeCall;
use Box2D::Vec2;

#   0 | struct b2Sweep
#   0 |   struct b2Vec2 localCenter
#   0 |     float32 x
#   4 |     float32 y
#     |   [sizeof=8, dsize=8, align=4
#     |    nvsize=8, nvalign=4]
#
#   8 |   struct b2Vec2 c0
#   8 |     float32 x
#  12 |     float32 y
#     |   [sizeof=8, dsize=8, align=4
#     |    nvsize=8, nvalign=4]
#
#  16 |   struct b2Vec2 c
#  16 |     float32 x
#  20 |     float32 y
#     |   [sizeof=8, dsize=8, align=4
#     |    nvsize=8, nvalign=4]
#
#  24 |   float32 a0
#  28 |   float32 a
#  32 |   float32 alpha0
#     | [sizeof=36, dsize=36, align=4
#     |  nvsize=36, nvalign=4]

class Box2D::Sweep is repr<CStruct> is export {
    method ^name($) { 'b2Sweep' }

    HAS Box2D::Vec2 $.localCenter;
    HAS Box2D::Vec2 $.c0;
    HAS Box2D::Vec2 $.c;
    has num32 $.a0;
    has num32 $.a;
    has num32 $.alpha0;
}
