use v6;
use NativeCall;
use Box2D::Vec2;
#~ use Box2D::Shape;

constant b2_maxPolygonVertices = 8;

#~ class Box2D::PolygonShape is Box2D::Shape is repr<CPPStruct> {
class Box2D::PolygonShape is repr<CPPStruct> {
    has Pointer $.vmt;
    has uint8 $.m_type;
    has num32 $.m_radius;

    HAS Box2D::Vec2 $.m_centroid;
    HAS Box2D::Vec2 @.m_vertices[b2_maxPolygonVertices] is CArray;
    HAS Box2D::Vec2 @.m_normals[b2_maxPolygonVertices] is CArray;
    has int32 $.m_count;

    method ^name($) { 'b2PolygonShape' }

    method !SetAsBox(num32 $hx, num32 $hy) is native<Box2D> { * }
    method SetAsBox($hx, $hy) { self!SetAsBox: $hx.Num, $hy.Num }

    method GetVertexCount() { $!m_count }

    method GetVertex($n) { say @!m_vertices[0]; @!m_vertices[$n] }
}
