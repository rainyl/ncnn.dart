import 'base.dart';
import 'allocator.dart';
import 'g/ncnn.g.dart' as cg;

class Option extends NativeObject<cg.ncnn_option_t> {
  Option.fromPointer(super.ptr);

  factory Option.create() {
    final p = cncnn.ncnn_option_create();
    return Option.fromPointer(p);
  }

  int get numThreads => cncnn.ncnn_option_get_num_threads(ptr);
  set numThreads(int v) => cncnn.ncnn_option_set_num_threads(ptr, v);

  int get useLocalPoolAllocator => cncnn.ncnn_option_get_use_local_pool_allocator(ptr);
  set useLocalPoolAllocator(int v) => cncnn.ncnn_option_set_use_local_pool_allocator(ptr, v);

  int get useVulkanCompute => cncnn.ncnn_option_get_use_vulkan_compute(ptr);
  set useVulkanCompute(int v) => cncnn.ncnn_option_set_use_vulkan_compute(ptr, v);

  set blobAllocator(Allocator allocator) => cncnn.ncnn_option_set_blob_allocator(ptr, allocator.ptr);
  set workspaceAllocator(Allocator allocator) =>
      cncnn.ncnn_option_set_workspace_allocator(ptr, allocator.ptr);

  static final finalizer = ncnnFinalizer<cg.ncnn_option_t>(cncnn.addresses.ncnn_option_destroy);
}
