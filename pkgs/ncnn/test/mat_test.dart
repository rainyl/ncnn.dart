import 'package:ncnn/ncnn.dart' as ncnn;
import 'package:test/test.dart';

void main() {
  group('Mat creations', () {
    test('Mat.create', () {
      final mat = ncnn.Mat.create();
      expect(mat.w, 0);
      expect(mat.h, 0);
      expect(mat.c, 0);
      expect(mat.d, 0);
      expect(mat.elemsize, 0);
      expect(mat.elempack, 0);
      expect(mat.cstep, 0);
      mat.dispose();
    });

    test('Mat.create1D', () {
      final mat = ncnn.Mat.create1D(10);
      expect(mat.w, 10);
      expect(mat.h, 1);
      expect(mat.c, 1);
      expect(mat.d, 1);
      expect(mat.elemsize, 4);
      expect(mat.elempack, 1);
      expect(mat.cstep, 10);
      mat.dispose();
    });

    test('Mat.create2D', () {
      final mat = ncnn.Mat.create2D(10, 20);
      expect(mat.w, 10);
      expect(mat.h, 20);
      expect(mat.c, 1);
      expect(mat.d, 1);
      expect(mat.elemsize, 4);
      expect(mat.elempack, 1);
      expect(mat.cstep, 10 * 20);
      mat.dispose();
    });

    test('Mat.create3D',(){
      final mat = ncnn.Mat.create3D(10, 20, 30);
      expect(mat.w, 10);
      expect(mat.h, 20);
      expect(mat.c, 30);
      expect(mat.d, 1);
      expect(mat.elemsize, 4);
      expect(mat.elempack, 1);
      expect(mat.cstep, 10 * 20);
      mat.dispose();
    });

    test('Mat.create4D', () {
      final mat = ncnn.Mat.create4D(10, 20, 30, 40);
      expect(mat.w, 10);
      expect(mat.h, 20);
      expect(mat.c, 40);
      expect(mat.d, 30);
      expect(mat.elemsize, 4);
      expect(mat.elempack, 1);
      expect(mat.cstep, 10 * 20 * 30);
      mat.dispose();
    });
  });

  group('Mat operations', () {
    final a = ncnn.Mat.create1D(2);
    final b = ncnn.Mat.create1D(2);
    a.fillFloat(2.0);
    b.fillFloat(2.0);
  });
}
