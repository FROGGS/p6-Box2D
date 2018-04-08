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

my $foo = Box2D::Vec2.new(3, 5);
$world.SetGravity($foo);

my $test2 = $world.GetGravity();
is $test2.x, 3, "Gravity's x value fits";
is $test2.y, 5, "Gravity's y value fits"; #,,

done-testing;
