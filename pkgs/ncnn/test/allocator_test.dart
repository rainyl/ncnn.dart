import 'package:ncnn/ncnn.dart' as ncnn;
import 'package:test/test.dart';

void main() {
  test('Allocator', () {
    final allocator = ncnn.Allocator.create();
    expect(allocator.ptr.address, isNot(0));
    allocator.dispose();
  });
}
