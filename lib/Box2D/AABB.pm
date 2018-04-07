use v6;
use NativeCall;
use Box2D::Vec2;

#   0 | struct b2StackEntry
#   0 |   char * data
#   8 |   int32 size
#  12 |   _Bool usedMalloc
#     | [sizeof=16, dsize=16, align=8
#     |  nvsize=16, nvalign=8]

class Box2D::AABB is repr<CStruct> {
    HAS Box2D::Vec2 $.lowerBound;
    HAS Box2D::Vec2 $.upperBound;

    method ^name($) { 'b2AABB' }
}

#~ struct b2AABB
#~ {

 #~ bool IsValid() const;


 #~ b2Vec2 GetCenter() const
 #~ {
  #~ return 0.5f * (lowerBound + upperBound);
 #~ }


 #~ b2Vec2 GetExtents() const
 #~ {
  #~ return 0.5f * (upperBound - lowerBound);
 #~ }


 #~ float32 GetPerimeter() const
 #~ {
  #~ float32 wx = upperBound.x - lowerBound.x;
  #~ float32 wy = upperBound.y - lowerBound.y;
  #~ return 2.0f * (wx + wy);
 #~ }

 #~ void Combine(const b2AABB& aabb)
 #~ {
  #~ lowerBound = b2Min(lowerBound, aabb.lowerBound);
  #~ upperBound = b2Max(upperBound, aabb.upperBound);
 #~ }


 #~ void Combine(const b2AABB& aabb1, const b2AABB& aabb2)
 #~ {
  #~ lowerBound = b2Min(aabb1.lowerBound, aabb2.lowerBound);
  #~ upperBound = b2Max(aabb1.upperBound, aabb2.upperBound);
 #~ }


#~ bool Contains(const b2AABB& aabb) const
 #~ {
  #~ bool result = true;
  #~ result = result && lowerBound.x <= aabb.lowerBound.x;
  #~ result = result && lowerBound.y <= aabb.lowerBound.y;
  #~ result = result && aabb.upperBound.x <= upperBound.x;
  #~ result = result && aabb.upperBound.y <= upperBound.y;
  #~ return result;
 #~ }

 #~ bool RayCast(b2RayCastOutput* output, const b2RayCastInput& input) const;

 #~ b2Vec2 lowerBound;
 #~ b2Vec2 upperBound;
#~ };

