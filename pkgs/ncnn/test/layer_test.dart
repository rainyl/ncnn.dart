import 'package:ncnn/ncnn.dart' as ncnn;
import 'package:test/test.dart';

void main() {
  group('Layer Creation', () {
    void testGetterSetter(ncnn.Layer layer) {
      expect(layer.isNull, false);
      layer.oneBlobOnly = true;
      expect(layer.oneBlobOnly, true);

      layer.supportInplace = true;
      expect(layer.supportInplace, true);

      layer.supportVulkan = true;
      expect(layer.supportVulkan, true);

      layer.supportPacking = true;
      expect(layer.supportPacking, true);

      layer.supportBF16Storage = true;
      expect(layer.supportBF16Storage, true);

      layer.supportImageStorage = true;
      expect(layer.supportImageStorage, true);

      expect(layer.bottoms, isEmpty);
      expect(layer.tops, isEmpty);
    }

    test('Layer.create', () {
      final layer = ncnn.Layer.create();
      testGetterSetter(layer);
      expect(layer.typeIndex, -1);
      expect(layer.name, isEmpty);
      expect(layer.type, ncnn.LayerType.INVALID);
      layer.dispose();
    });

    test('Layer.fromType', () {
      final idx = ncnn.Layer.typeToIndex(ncnn.LayerType.BinaryOp);
      final layer = ncnn.Layer.fromType(ncnn.LayerType.BinaryOp);
      testGetterSetter(layer);
      expect(layer.typeIndex, idx);
      expect(layer.name, '');
      expect(layer.type, '');
      layer.dispose();
    });

    test('Layer.fromTypeIndex', () {
      final idx = ncnn.Layer.typeToIndex(ncnn.LayerType.Flatten);
      expect(idx, isNot(-1));
      final layer = ncnn.Layer.fromTypeIndex(idx);
      testGetterSetter(layer);
      expect(layer.typeIndex, idx);
      expect(layer.name, '');
      expect(layer.type, '');
      layer.dispose();
    });
  });

  test('Layer.typeToIndex', () {
    for (final type in ncnn.LayerType.values) {
      final idx = ncnn.Layer.typeToIndex(type);
      if (type == ncnn.LayerType.INVALID) {
        expect(idx, -1);
      } else {
        expect(idx, isNot(-1));
      }
    }
  });
}
