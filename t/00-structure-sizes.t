use v6;
use lib 't';
use CompileTestLib;
use NativeCall;
use Test;
use Box2D;
use Box2D::Mat22;

plan 20;

compile_cpp_test_lib('00-structure-sizes');

for Box2D::AABB,
    Box2D::BlockAllocator,
    #~ Box2D::Block,
    Box2D::Body,
    Box2D::BodyDef,
    Box2D::BroadPhase,
    #~ Box2D::Chunk,
    #~ Box2D::ClipVertex,
    #~ Box2D::ContactFeature,
    #~ Box2D::ContactID,
    #~ Box2D::ContactListener,
    Box2D::ContactManager,
    #~ Box2D::ContactRegister,
    #~ Box2D::DistanceProxy,
    Box2D::DynamicTree,
    #~ Box2D::Filter,
    #~ Box2D::Fixture,
    #~ Box2D::Island,
    #~ Box2D::ManifoldPoint,
    Box2D::Mat22,
    Box2D::Pair,
    Box2D::PolygonShape,
    Box2D::Profile,
    #~ Box2D::RayCastCallback,
    #~ Box2D::RayCastInput,
    Box2D::Rot,
    Box2D::Shape,
    Box2D::StackAllocator,
    Box2D::StackEntry,
    Box2D::Sweep,
    #~ Box2D::TimeStep,
    #~ Box2D::TOIInput,
    #~ Box2D::TOIOutput,
    Box2D::Transform,
    Box2D::TreeNode,
    Box2D::Vec2,
    #~ Box2D::VelocityConstraintPoint,
    Box2D::World
    #~ Box2D::WorldQueryWrapper,
    #~ Box2D::WorldRayCastWrapper
{
    sub sizeof() returns int32 is mangled { ... }
    trait_mod:<is>(&sizeof, :native('./00-structure-sizes'));
    trait_mod:<is>(&sizeof, :symbol('sizeof_' ~ $_.^name));

    is nativesizeof($_), sizeof(), "sizeof($_.^name())";

    #shell 'dumpbin /exports 11-cpp.dll';
    #shell 'clang --shared -fPIC -o 11-cpp.so t/04-nativecall/11-cpp.cpp';
    #shell 'nm ./lib00-structure-sizes.so';
    #shell 'clang -cc1 -fdump-record-layouts -I/usr/include t/00-structure-sizes.cpp';
}
