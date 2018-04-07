use v6;
use Box2D;
use NativeCall;
use Test;

plan 24;

my $vec = Box2D::Vec2.new(10, 11);

ok $vec, "new";

is $vec.x, 10, "Get x";
is $vec.y, 11, "Get y";

$vec.x = 3e0;
$vec.y = 4e0;

is $vec.x, 3, "Set x";
is $vec.y, 4, "Set y";

$vec.Set(5, 6);

is $vec.x, 5, "Set";
is $vec.y, 6, "Set";

$vec.y = 5e0;

is-approx $vec.Length, 7.07106781005859, "Length";

is $vec.LengthSquared, 50, "LengthSquared";

is-approx $vec.Normalize, 7.07106781005859, "Normalize";

$vec.SetZero();

is $vec.x, 0, "SetZero";
is $vec.y, 0, "SetZero";

ok $vec.IsValid(), "IsValid";

my $a = Box2D::Vec2.new(1, 2);
my $b = Box2D::Vec2.new(3, 4);
my $s = 9;

{
    my $c = $a + $b;
    is $c.x, $a.x + $b.x, "b2Vec2 + b2Vec2";
    is $c.y, $a.y + $b.y, "b2Vec2 + b2Vec2";
}

{
    my $c = $a - $b;
    is $c.x, $a.x - $b.x, "b2Vec2 - b2Vec2";
    is $c.y, $a.y - $b.y, "b2Vec2 - b2Vec2";
}

{
    my $c = $s * $a;
    is $c.x, $s * $a.x, "scalar * b2Vec2";
    is $c.y, $s * $a.y, "scalar * b2Vec2";
}

{
    ok( !( $a == $b ), "b2Vec2 == b2Vec2" );
    ok( !( $b == $a ), "b2Vec2 == b2Vec2" );
    ok( $a == $a,      "b2Vec2 == b2Vec2" );
    ok( $b == $b,      "b2Vec2 == b2Vec2" );

    my $c = Box2D::Vec2.new($a.x, $a.y);
    ok( $a == $c, "b2Vec2 == b2Vec2" );
}
