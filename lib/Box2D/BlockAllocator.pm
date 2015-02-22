use v6;
use NativeCall;

my int32 $b2_chunkSize           = 16 * 1024;
my int32 $b2_maxBlockSize        = 640;
my int32 $b2_blockSizes          = 14;
my int32 $b2_chunkArrayIncrement = 128;

class Box2D::Block is repr<CStruct> {
    has Box2D::Block $.next;
}

class Box2D::Chunk is repr<CStruct> {
    has int32     $.blockSize;
    has Box2D::Block $.blocks;
};

#| This is a small object allocator used for allocating small
#| objects that persist for more than one time step.
#| See: http://www.codeproject.com/useritems/Small_Block_Allocator.asp
class Box2D::BlockAllocator is repr<CPPStruct> is export { # _ZN16b2BlockAllocator8AllocateEi
#~ public:

    #| Allocate memory. This will use b2Alloc if the size is larger than b2_maxBlockSize.
    method allocate(int32 $size) returns OpaquePointer is symbol<b2BlockAllocator::Allocate> is native<libBox2D> { * }

    #| Free memory. This will use b2Free if the size is larger than b2_maxBlockSize.
    method free(Pointer[void] $p, int32 $size) is symbol<b2BlockAllocator::Free> is native<libBox2D> { * }

    method clear() is symbol<b2BlockAllocator::Clear> is native<libBox2D> { * }

#~ private:
    has Box2D::Chunk $.m_chunks;
    has int32 $.m_chunkCount;
    has int32 $.m_chunkSpace;

    #~ has b2Block* $.m_freeLists[b2_blockSizes];
    has OpaquePointer $.m_freeLists;

    #~ has int32 $.s_blockSizes[b2_blockSizes];
    has OpaquePointer $.s_blockSizes;
    #~ has uint8 $.s_blockSizeLookup[b2_maxBlockSize + 1];
    has OpaquePointer $.s_blockSizeLookup;
    #~ has bool $.s_blockSizeLookupInitialized;
    has int8 $.s_blockSizeLookupInitialized;
}
