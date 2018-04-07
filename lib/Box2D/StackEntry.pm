use v6;
use NativeCall;

#   0 | struct b2StackEntry
#   0 |   char * data
#   8 |   int32 size
#  12 |   _Bool usedMalloc
#     | [sizeof=16, dsize=16, align=8
#     |  nvsize=16, nvalign=8]

class Box2D::StackEntry is repr<CStruct> {
    has Str   $.data;
    has int32 $.size;
    has int8  $.usedMalloc;

    method ^name($) { 'b2StackEntry' }
}
