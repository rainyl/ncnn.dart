import 'package:ncnn/ncnn.dart' as ncnn;
import 'package:test/test.dart';

void main() {
  group('Net', () {
    test('Net.create', () {
      final net = ncnn.Net.create();
      expect(net.isNull, false);
      net.dispose();
    });
  });
}
