use v6;

class Box2D::Pair is repr<CStruct> is export {
    method ^name($) { 'b2Pair' }
    has int32 $.proxyIdA is rw;
    has int32 $.proxyIdB is rw;
}
