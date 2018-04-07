use v6;
use NativeCall;
use Box2D::Vec2;

#   0 | struct b2Mat22
#   0 |   struct b2Vec2 ex
#   0 |     float32 x
#   4 |     float32 y
#     |   [sizeof=8, dsize=8, align=4
#     |    nvsize=8, nvalign=4]
#
#   8 |   struct b2Vec2 ey
#   8 |     float32 x
#  12 |     float32 y
#     |   [sizeof=8, dsize=8, align=4
#     |    nvsize=8, nvalign=4]
#
#     | [sizeof=16, dsize=16, align=4
#     |  nvsize=16, nvalign=4]

class Box2D::Mat22 is repr<CStruct> is export {
    HAS Box2D::Vec2 $.ex;
    HAS Box2D::Vec2 $.ey;

    method ^name($) { 'b2Mat22' }
}
