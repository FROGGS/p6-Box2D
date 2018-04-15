use v6;
use NativeCall;
use Box2D::Vec2;
use Box2D::BlockAllocator;
use Box2D::Shape;

constant b2_maxPolygonVertices = 8;

#enum Type
#{
#    e_circle = 0,
#    e_edge = 1,
#    e_polygon = 2,
#    e_chain = 3,
#    e_typeCount = 4
#};

class Box2D::PolygonShape is repr<CPPStruct> {
    has Pointer $.vmt;
    has uint8 $.m_type is rw;
    has num32 $.m_radius is rw;

    HAS Box2D::Vec2 $.m_centroid is rw;
    HAS Box2D::Vec2 @.m_vertices[b2_maxPolygonVertices] is CArray;
    HAS Box2D::Vec2 @.m_normals[b2_maxPolygonVertices] is CArray;
    has int32 $.m_count is rw;

    method ^name($) { 'b2PolygonShape' }

    method !SetAsBox(num32 $hx, num32 $hy) is native<Box2D> { * }
    method SetAsBox($hx, $hy) { self!SetAsBox: $hx.Num, $hy.Num }

    method GetVertexCount() { $!m_count }

    method GetVertex($n) { say @!m_vertices[0]; @!m_vertices[$n] }

    #b2Shape* b2PolygonShape::Clone(b2BlockAllocator* allocator) const
    method Clone(Box2D::BlockAllocator $ba is rw) returns Box2D::Shape is cpp-const is native<Box2D> { * }

    method Validate() returns bool is cpp-const is native<Box2D> { * }

    submethod BUILD(
        :$type,
        :$radius,
        :$centroid,
        :$count,
    ) {
        $!m_type      = $type     // 2; # e_polygon
        $!m_radius    = $radius   // 2.0e0 * 0.005e0; # b2_polygonRadius;
        $!m_centroid := $centroid // Box2D::Vec2.new(0e0, 0e0);
        $!m_count     = $count    // 0;
    }
}

#class b2PolygonShape : public b2Shape
#{
#public:
#	b2PolygonShape();
#
#	/// Implement b2Shape.
#	b2Shape* Clone(b2BlockAllocator* allocator) const override;
#
#	/// @see b2Shape::GetChildCount
#	int32 GetChildCount() const override;
#
#	/// Create a convex hull from the given array of local points.
#	/// The count must be in the range [3, b2_maxPolygonVertices].
#	/// @warning the points may be re-ordered, even if they form a convex polygon
#	/// @warning collinear points are handled but not removed. Collinear points
#	/// may lead to poor stacking behavior.
#	void Set(const b2Vec2* points, int32 count);
#
#	/// Build vertices to represent an axis-aligned box centered on the local origin.
#	/// @param hx the half-width.
#	/// @param hy the half-height.
#	void SetAsBox(float32 hx, float32 hy);
#
#	/// Build vertices to represent an oriented box.
#	/// @param hx the half-width.
#	/// @param hy the half-height.
#	/// @param center the center of the box in local coordinates.
#	/// @param angle the rotation of the box in local coordinates.
#	void SetAsBox(float32 hx, float32 hy, const b2Vec2& center, float32 angle);
#
#	/// @see b2Shape::TestPoint
#	bool TestPoint(const b2Transform& transform, const b2Vec2& p) const override;
#
#	/// Implement b2Shape.
#	bool RayCast(b2RayCastOutput* output, const b2RayCastInput& input,
#					const b2Transform& transform, int32 childIndex) const override;
#
#	/// @see b2Shape::ComputeAABB
#	void ComputeAABB(b2AABB* aabb, const b2Transform& transform, int32 childIndex) const override;
#
#	/// @see b2Shape::ComputeMass
#	void ComputeMass(b2MassData* massData, float32 density) const override;
#
#	/// Validate convexity. This is a very time consuming operation.
#	/// @returns true if valid
#	bool Validate() const;
#
#	b2Vec2 m_centroid;
#	b2Vec2 m_vertices[b2_maxPolygonVertices];
#	b2Vec2 m_normals[b2_maxPolygonVertices];
#	int32 m_count;
#};
#
#inline b2PolygonShape::b2PolygonShape()
#{
#	m_type = e_polygon;
#	m_radius = b2_polygonRadius;
#	m_count = 0;
#	m_centroid.SetZero();
#}
