use v6;
unit module Box2D::Vec2;
use NativeCall;

my constant b2_epsilon = 1.19209290e-07;
sub b2IsValid(num32 \n) { use nqp; !nqp::isnanorinf(n) }

#   0 | struct b2Vec2
#   0 |   float32 x
#   4 |   float32 y
#     | [sizeof=8, dsize=8, align=4
#     |  nvsize=8, nvalign=4]

class Box2D::Vec2 is repr<CStruct> is export {
    has num32 $.x is rw;
    has num32 $.y is rw;

    method ^name($) { 'b2Vec2' }

    multi method new(Num(Numeric) $x, Num(Numeric) $y = 0e0) {
        self.bless( :$x, :$y )
    }

    multi method new(Num(Numeric) :$x = 0e0, Num(Numeric) :$y = 0e0) {
        self.bless( :$x, :$y )
    }

    #| Set this vector to all zeros.
    method SetZero() {
        $!x = 0e0;
        $!y = 0e0;
    }

    #| Set this vector to some specified coordinates.
    method Set(Num(Numeric) $x, Num(Numeric) $y) {
        $!x = $x;
        $!y = $y;
    }

    #| Get the length of this vector (the norm).
    method Length() { ($!x * $!x + $!y * $!y).sqrt }

    #| Get the length squared. For performance, use this instead of
    #| b2Vec2::Length (if possible).
    method LengthSquared() { $!x * $!x + $!y * $!y }

    #| Convert this vector into a unit vector. Returns the length.
    method Normalize() {
        my num64 $length = self.Length; # num32 is buggy
        return 0e0 if $length < b2_epsilon;

        my num64 $invLength = 1e0 / $length;
        $!x *= $invLength;
        $!y *= $invLength;
        $length;
    }

    #| Does this vector contain finite coordinates?
    method IsValid() { b2IsValid($!x) && b2IsValid($!y) }

    #| Get the skew vector such that dot(skew_vec, other) == cross(vec, other)
    method Skew() { Box2D::Vec2.new: -$!y, $!x }
}

#~ /// Negate this vector.
#~ b2Vec2 operator -() const { b2Vec2 v; v.Set(-x, -y); return v; }

#~ /// Read from and indexed element.
#~ float32 operator () (int32 i) const
#~ {
    #~ return (&x)[i];
#~ }

#~ /// Write to an indexed element.
#~ float32& operator () (int32 i)
#~ {
    #~ return (&x)[i];
#~ }

#| Add a vector to this vector.
multi infix:<+>(Box2D::Vec2 \a, Box2D::Vec2 \b) is export {
    Box2D::Vec2.new: a.x + b.x, a.y + b.y
}

#| Subtract a vector from this vector.
multi infix:<->(Box2D::Vec2 \a, Box2D::Vec2 \b) is export {
    Box2D::Vec2.new: a.x - b.x, a.y - b.y
}

#| Multiply this vector by a scalar.
multi infix:<*>(Box2D::Vec2 \a, \b) is export {
    Box2D::Vec2.new: a.x * b, a.y * b
}
multi infix:<*>(\a, Box2D::Vec2 \b) is export {
    Box2D::Vec2.new: a * b.x, a * b.y
}

multi infix:<==>(Box2D::Vec2 \a, Box2D::Vec2 \b) is export {
    a.x == b.x && a.y == b.y
}
