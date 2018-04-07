#ifdef _WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

#include <Box2D/Box2D.h>

#define s(name)     DLLEXPORT int sizeof_ ## name () { return sizeof(name); }

s(b2AABB)
s(b2BlockAllocator)
//~ s(b2Block)
s(b2Body)
s(b2BodyDef)
s(b2BroadPhase)
//~ s(b2Chunk)
s(b2ClipVertex)
s(b2ContactFeature)
s(b2ContactID)
s(b2ContactListener)
s(b2ContactManager)
s(b2ContactRegister)
s(b2DistanceProxy)
s(b2DynamicTree)
s(b2Filter)
s(b2Fixture)
//~ s(b2Island)
s(b2ManifoldPoint)
s(b2Mat22)
s(b2Pair)
s(b2PolygonShape)
s(b2Profile)
s(b2RayCastCallback)
s(b2RayCastInput)
s(b2Rot)
s(b2Shape)
s(b2StackAllocator)
s(b2StackEntry)
s(b2Sweep)
s(b2TimeStep)
s(b2TOIInput)
s(b2TOIOutput)
s(b2Transform)
s(b2TreeNode)
s(b2Vec2)
//~ s(b2VelocityConstraintPoint)
s(b2World)
//~ s(b2WorldQueryWrapper)
//~ s(b2WorldRayCastWrapper)