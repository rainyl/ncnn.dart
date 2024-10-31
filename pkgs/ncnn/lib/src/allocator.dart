import 'base.dart';
import 'g/ncnn.g.dart' as cg;

class Allocator extends NativeObject<cg.ncnn_allocator_t> {
  Allocator.fromPointer(super.ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }
  static final finalizer = ncnnFinalizer<cg.ncnn_allocator_t>(cncnn.addresses.ncnn_allocator_destroy);

  @override
  void dispose() {
    finalizer.detach(this);
    cncnn.ncnn_allocator_destroy(ptr);
  }

  factory Allocator.create({bool unlocked = false}) {
    final p = unlocked
        ? cncnn.ncnn_allocator_create_unlocked_pool_allocator()
        : cncnn.ncnn_allocator_create_pool_allocator();
    return Allocator.fromPointer(p);
  }
}
