use v6;
use NativeCall;
use Box2D::BroadPhase;

class Box2D::ContactManager is repr<CPPStruct> is export {
    method ^name($) { 'b2ContactManager' }

#~ public:
    #~ b2ContactManager();

    #| Broad-phase callback.
    #~ void AddPair(void* proxyUserDataA, void* proxyUserDataB);

    #~ void FindNewContacts();

    #~ void Destroy(b2Contact* c);

    #~ void Collide();

    HAS Box2D::BroadPhase $.m_broadPhase;

    has Pointer $.m_contactList;     # b2Contact*;
    has int32   $.m_contactCount;
    has Pointer $.m_contactFilter;   # b2ContactFilter*;
    has Pointer $.m_contactListener; # b2ContactListener*;
    has Pointer $.m_allocator;       # b2BlockAllocator*;
};