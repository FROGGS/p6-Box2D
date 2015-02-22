use v6;
use Box2D::StackAllocator;
use Test;

plan 3;

ok (my $sa = Box2D::StackAllocator.new), 'can instantiate Box2D::StackAllocator';
ok (my $p  = $sa.allocate(32)),          'can allocate 32 byte of memory';
$sa.free($p);                       pass 'freed allocated memory and still alive';
