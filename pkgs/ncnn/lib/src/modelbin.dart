import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'datareader.dart';
import 'g/ncnn.g.dart' as cg;
import 'mat.dart';

class ModelBin extends NativeObject<cg.ncnn_modelbin_t> {
  ModelBin.fromPointer(super.ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  @override
  void dispose() {
    finalizer.detach(this);
    cncnn.ncnn_modelbin_destroy(ptr);
  }

  factory ModelBin.fromDatareader(Datareader reader) {
    final p = cncnn.ncnn_modelbin_create_from_datareader(reader.ptr);
    return ModelBin.fromPointer(p);
  }

  factory ModelBin.fromMatArray(List<Mat> mats) {
    final pmats = calloc<cg.ncnn_mat_t>(mats.length);
    for (var i = 0; i < mats.length; i++) {
      pmats[i] = mats[i].ptr;
    }
    final p = cncnn.ncnn_modelbin_create_from_mat_array(pmats, mats.length);
    return ModelBin.fromPointer(p);
  }

  static final finalizer = ncnnFinalizer<cg.ncnn_modelbin_t>(cncnn.addresses.ncnn_modelbin_destroy);
}
