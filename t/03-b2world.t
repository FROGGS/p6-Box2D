use v6;
use lib 'lib';
use Box2D;
use Test;

plan 5;

my $gravity = Box2D::Vec2.new(0, -10);
my $world   = Box2D::World.new($gravity);
ok $world ~~ Box2D::World, 'Can create a world';

my $test = $world.GetGravity();

is $test.x,   0, "Gravity's x value fits";
is $test.y, -10, "Gravity's y value fits"; # ,,

my $foo = Box2D::Vec2.new(0, 1);
$world.SetGravity($foo);

$test = $world.GetGravity();

is $test.x, 0, "Gravity's x value fits";
is $test.y, 1, "Gravity's y value fits"; #,,

done-testing;
