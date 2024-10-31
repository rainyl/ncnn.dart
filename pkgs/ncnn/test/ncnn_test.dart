import 'package:ncnn/ncnn.dart' as ncnn;
import 'package:test/test.dart';

void main() {
  group('core functions', () {

    setUp(() {
      // Additional setup goes here.
    });

    test('version', () {
      final version = ncnn.version();
      print(version);
    });
  });
}
