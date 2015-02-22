use v6;
use NativeCall;

my int32 $b2_stackSize       = 100 * 1024; # 100k
my int32 $b2_maxStackEntries = 32;

class Box2D::StackEntry is repr<CStruct> {
    has Str   $.data;
    has int32 $.size;
    has int8  $.usedMalloc;
}

#| This is a stack allocator used for fast per step allocations.
#| You must nest allocate/free pairs. The code will assert
#| if you try to interleave multiple allocate/free pairs.
class Box2D::StackAllocator is repr<CPPStruct> is export {
#~ public:

    method allocate(int32 $.size) returns OpaquePointer is symbol<b2StackAllocator::Allocate>         is native<libBox2D> { * }
    method free(Pointer[void] $p)                       is symbol<b2StackAllocator::Free>             is native<libBox2D> { * }
    method get-max-allocation() returns int32           is symbol<b2StackAllocator::GetMaxAllocation> is native<libBox2D> { * }

#~ private:

    has Str   $.m_data; # char m_data[b2_stackSize];
    has int32 $.m_index;

    has int32 $.m_allocation;
    has int32 $.m_maxAllocation;

    has Box2D::StackEntry $.m_entries; # m_entries[b2_maxStackEntries];
    has int32 $.m_entryCount;
}
