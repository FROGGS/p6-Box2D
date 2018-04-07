use v6;

#   0 | struct b2Profile
#   0 |   float32 step
#   4 |   float32 collide
#   8 |   float32 solve
#  12 |   float32 solveInit
#  16 |   float32 solveVelocity
#  20 |   float32 solvePosition
#  24 |   float32 broadphase
#  28 |   float32 solveTOI
#     | [sizeof=32, dsize=32, align=4
#     |  nvsize=32, nvalign=4]

class Box2D::Profile is repr<CStruct> is export {
    method ^name($) { 'b2Profile' }

    has num32 $.step;
    has num32 $.collide;
    has num32 $.solve;
    has num32 $.solveInit;
    has num32 $.solveVelocity;
    has num32 $.solvePosition;
    has num32 $.broadphase;
    has num32 $.solveTOI;
}
