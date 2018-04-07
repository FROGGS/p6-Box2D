use v6;
use NativeCall;

my int32 $b2_chunkSize           = 16 * 1024;
constant $b2_maxBlockSize        = 640;
constant $b2_blockSizes          = 14;
my int32 $b2_chunkArrayIncrement = 128;

class Box2D::Block is repr<CStruct> {
    has Box2D::Block $.next;
}

class Box2D::Chunk is repr<CStruct> {
    has int32     $.blockSize;
    has Box2D::Block $.blocks;
};

#    0 | class b2BlockAllocator
#    0 |   struct b2Chunk * m_chunks
#    8 |   int32 m_chunkCount
#   12 |   int32 m_chunkSpace
#   16 |   struct b2Block *[14] m_freeLists
#      | [sizeof=128, dsize=128, align=8,
#      |  nvsize=128, nvalign=8]

#| This is a small object allocator used for allocating small
#| objects that persist for more than one time step.
#| See: http://www.codeproject.com/useritems/Small_Block_Allocator.asp
class Box2D::BlockAllocator is repr<CPPStruct> is export {
    method ^name($) { 'b2BlockAllocator' }

#~ public:

    #| Allocate memory. This will use b2Alloc if the size is larger than b2_maxBlockSize.
    method allocate(int32 $size) returns Pointer is symbol<b2BlockAllocator::Allocate> is native<Box2D> { * }

    #| Free memory. This will use b2Free if the size is larger than b2_maxBlockSize.
    method free(Pointer[void] $p, int32 $size) is symbol<b2BlockAllocator::Free> is native<Box2D> { * }

    method clear() is symbol<b2BlockAllocator::Clear> is native<Box2D> { * }

#~ private:
    has Box2D::Chunk $.m_chunks;
    has int32 $.m_chunkCount;
    has int32 $.m_chunkSpace;

    HAS Box2D::Block @.m_freeLists[$b2_blockSizes] is CArray; # <--- die Array-Länge wird ignoriert

    #HAS int32 @.s_blockSizes[$b2_blockSizes] is CArray;
    #HAS uint8 @.s_blockSizeLookup[$b2_maxBlockSize + 1] is CArray;
    #has bool $.s_blockSizeLookupInitialized;
}
