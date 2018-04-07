use v6;
use NativeCall;

enum Box2D::ShapeType is export (
    e_circle    => 0,
    e_edge      => 1,
    e_polygon   => 2,
    e_chain     => 3,
    e_typeCount => 4,
);

class Box2D::Shape is repr<CPPStruct> is export {
    has Pointer $.vmt;
    has uint8 $.m_type;
    has num32 $.m_radius;

    method ^name($) { 'b2Shape' }
}
