use v6;
use Box2D::Vec2;
use Box2D::Body;
use Box2D::World;
use Box2D::Shape;
use Box2D::PolygonShape;
use Box2D::Filter;
use Box2D::Fixture;
use Box2D::ClipVertex;

#| Add a vector to this vector.
multi infix:<+>(Box2D::Vec2 \a, Box2D::Vec2 \b) is export {
    Box2D::Vec2.new: a.x + b.x, a.y + b.y # ++
}

#| Subtract a vector from this vector.
multi infix:<->(Box2D::Vec2 \a, Box2D::Vec2 \b) is export {
    Box2D::Vec2.new: a.x - b.x, a.y - b.y # --
}

#| Multiply this vector by a scalar.
multi infix:<*>(Box2D::Vec2 \a, \b) is export {
    Box2D::Vec2.new: a.x * b, a.y * b # **
}
multi infix:<*>(\a, Box2D::Vec2 \b) is export {
    Box2D::Vec2.new: a * b.x, a * b.y # ##
}

multi infix:<==>(Box2D::Vec2 \a, Box2D::Vec2 \b) is export {
    a.x == b.x && a.y == b.y # ==
}



#define	b2_maxFloat		FLT_MAX
#define	b2_epsilon		FLT_EPSILON
#define b2_pi			3.14159265359f

# Collision

# The maximum number of contact points between two convex shapes. Do
# not change this value.
#define b2_maxManifoldPoints	2

# The maximum number of vertices on a convex polygon. You cannot increase
# this too much because b2BlockAllocator has a maximum object size.
#define b2_maxPolygonVertices	8

# This is used to fatten AABBs in the dynamic tree. This allows proxies
# to move by a small amount without triggering a tree adjustment.
# This is in meters.
#define b2_aabbExtension		0.1f

# This is used to fatten AABBs in the dynamic tree. This is used to predict
# the future position based on the current displacement.
# This is a dimensionless multiplier.
#define b2_aabbMultiplier		2.0f

# A small length used as a collision and constraint tolerance. Usually it is
# chosen to be numerically significant, but visually insignificant.
constant b2_linearSlop is export = 0.005e0;

# A small angle used as a collision and constraint tolerance. Usually it is
# chosen to be numerically significant, but visually insignificant.
#define b2_angularSlop			(2.0f / 180.0f * b2_pi)

# The radius of the polygon/edge shape skin. This should not be modified. Making
# this smaller means polygons will have an insufficient buffer for continuous collision.
# Making it larger may create artifacts for vertex collision.
constant b2_polygonRadius is export = 2.0e0 * b2_linearSlop;

# Maximum number of sub-steps per contact in continuous physics simulation.
#define b2_maxSubSteps			8


## Dynamics

# Maximum number of contacts to be handled to solve a TOI impact.
#define b2_maxTOIContacts			32

# A velocity threshold for elastic collisions. Any collision with a relative linear
# velocity below this threshold will be treated as inelastic.
#define b2_velocityThreshold		1.0f

# The maximum linear position correction used when solving constraints. This helps to
# prevent overshoot.
#define b2_maxLinearCorrection		0.2f

# The maximum angular position correction used when solving constraints. This helps to
# prevent overshoot.
#define b2_maxAngularCorrection		(8.0f / 180.0f * b2_pi)

# The maximum linear velocity of a body. This limit is very large and is used
# to prevent numerical problems. You shouldn't need to adjust this.
#define b2_maxTranslation			2.0f
#define b2_maxTranslationSquared	(b2_maxTranslation * b2_maxTranslation)

# The maximum angular velocity of a body. This limit is very large and is used
# to prevent numerical problems. You shouldn't need to adjust this.
#define b2_maxRotation				(0.5f * b2_pi)
#define b2_maxRotationSquared		(b2_maxRotation * b2_maxRotation)

# This scale factor controls how fast overlap is resolved. Ideally this would be 1 so
# that overlap is removed in one time step. However using values close to 1 often lead
# to overshoot.
#define b2_baumgarte				0.2f
#define b2_toiBaugarte				0.75f


# Sleep

# The time that a body must be still before it will go to sleep.
#define b2_timeToSleep				0.5f

# A body cannot sleep if its linear velocity is above this tolerance.
#define b2_linearSleepTolerance		0.01f

# A body cannot sleep if its angular velocity is above this tolerance.
#define b2_angularSleepTolerance	(2.0f / 180.0f * b2_pi)









#sub EXPORT { %(
#    Box2D::Vec2::EXPORT::DEFAULT::,
    #Box2D::Shape::EXPORT::DEFAULT::,
#    '&Shape' => 42, #Box2D::Shape,
#) }

module Box2D { }

=finish

package Box2D;

use warnings;
use strict;
our @ISA = qw(Exporter);

our $VERSION = '0.07';

require XSLoader;
XSLoader::load( 'Box2D', $VERSION );
require Exporter;

our @EXPORT_OK   = ();
our %EXPORT_TAGS = ();

use constant {

    #b2Body Type
    b2_staticBody    => 0,
    b2_kinematicBody => 1,
    b2_dynamicBody   => 2,

    #b2Shape Type
    e_unknown   => -1,
    e_circle    => 0,
    e_polygon   => 1,
    e_typeCount => 2,

};

BEGIN {
    *Box2D::b2World::SetContactListener = sub {
        if ( UNIVERSAL::isa( $_[1], "Box2D::b2ContactListener" ) ) {
            $_[0]->SetContactListenerXS( $_[1]->_getListener() );
        }
        else {
            $_[0]->SetContactListenerXS( $_[1] );
        }
    };

    *Box2D::b2World::RayCast = sub {
        my $world    = shift;
        my $callback = shift;
        if ( UNIVERSAL::isa( $callback, "Box2D::b2RayCastCallback" ) ) {
            $world->RayCastXS( $callback->_getCallback(), @_ );
        }
        else {
            $world->RayCastXS( $callback, @_ );
        }
    };
}

package    # Hide from PAUSE
    Box2D::b2Vec2;

use overload
    '+'    => '_add',
    '-'    => '_sub',
    '*'    => '_mul',
    '=='   => '_eql',
    'bool' => sub {1};

sub _add {
    my ( $self, $other ) = @_;

    return Box2D::b2Math::b2AddV2V2( $other, $self );
}

sub _sub {
    my ( $self, $other, $swap ) = @_;

    if ($swap) {
        return Box2D::b2Math::b2SubV2V2( $other, $self );
    }
    else {
        return Box2D::b2Math::b2SubV2V2( $self, $other );
    }
}

# Multiplication is defined between a vector and scalar. Multiplying two
# vectors is ambiguous because either cross product or dot product may
# be intended. Use b2CrossV2V2 or b2DotV2V2 for those operations.
sub _mul {
    my ( $self, $other ) = @_;

    return Box2D::b2Math::b2MulSV2( $other, $self );
}

sub _eql {
    my ( $self, $other ) = @_;

    return Box2D::b2Math::b2EqlV2V2( $self, $other );
}

1;    # End of Box2D
