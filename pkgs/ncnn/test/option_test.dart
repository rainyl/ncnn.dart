import 'package:ncnn/ncnn.dart' as ncnn;
import 'package:test/test.dart';

void main() {
  test('Option', () {
    final option = ncnn.Option.create();
    option.numThreads = 1;
    expect(option.numThreads, 1);

    option.useLocalPoolAllocator = 0;
    expect(option.useLocalPoolAllocator, 0);

    option.useVulkanCompute = 1;
    expect(option.useVulkanCompute, 1);

    final blobAllocator = ncnn.Allocator.create();
    option.blobAllocator = blobAllocator;

    final workspaceAllocator = ncnn.Allocator.create();
    option.workspaceAllocator = workspaceAllocator;

    option.dispose();
  });
}
