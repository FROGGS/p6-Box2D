use v6;
use NativeCall;
use Box2D::Rot;
use Box2D::Vec2;

#   0 | struct b2Transform
#   0 |   struct b2Vec2 p
#   0 |     float32 x
#   4 |     float32 y
#     |   [sizeof=8, dsize=8, align=4
#     |    nvsize=8, nvalign=4]
#   8 |   struct b2Rot q
#   8 |     float32 s
#  12 |     float32 c
#     |   [sizeof=8, dsize=8, align=4
#     |    nvsize=8, nvalign=4]
#
#     | [sizeof=16, dsize=16, align=4
#     |  nvsize=16, nvalign=4]

class Box2D::Transform is repr<CStruct> is export {
    method ^name($) { 'b2Transform' }

    HAS Box2D::Vec2 $.p;
    HAS Box2D::Rot $.q;
}
