use v6;
use NativeCall;
use Box2D::StackEntry;

constant b2_stackSize       = 100 * 1024; # 100k
constant b2_maxStackEntries = 32;

#         0 | class b2StackAllocator
#         0 |   char [102400] m_data
#    102400 |   int32 m_index
#    102404 |   int32 m_allocation
#    102408 |   int32 m_maxAllocation
#    102416 |   struct b2StackEntry [32] m_entries
#    102928 |   int32 m_entryCount
#           | [sizeof=102936, dsize=102932, align=8,
#           |  nvsize=102932, nvalign=8]

#| This is a stack allocator used for fast per step allocations.
#| You must nest allocate/free pairs. The code will assert
#| if you try to interleave multiple allocate/free pairs.
class Box2D::StackAllocator is repr<CPPStruct> is export {
    method ^name($) { 'b2StackAllocator' }

#~ public:

    method allocate(int32 $.size) returns OpaquePointer is symbol<b2StackAllocator::Allocate>         is native<Box2D> { * }
    method free(Pointer[void] $p)                       is symbol<b2StackAllocator::Free>             is native<Box2D> { * }
    method get-max-allocation() returns int32           is symbol<b2StackAllocator::GetMaxAllocation> is native<Box2D> { * }

#~ private:

    HAS uint8 @.m_data[b2_stackSize] is CArray;
    has int32 $.m_index;

    has int32 $.m_allocation;
    has int32 $.m_maxAllocation;

    HAS Box2D::StackEntry @.m_entries[b2_maxStackEntries] is CArray;
    has int32 $.m_entryCount;
}
