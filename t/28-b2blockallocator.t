use v6;
use Box2D::BlockAllocator;
use Test;

plan 3;

ok (my $ba = Box2D::BlockAllocator.new), 'can instantiate Box2D::BlockAllocator';
ok (my $p  = $ba.allocate(32)),          'can allocate 32 byte of memory';
$ba.free($p, 32);                   pass 'freed allocated memory and still alive';
