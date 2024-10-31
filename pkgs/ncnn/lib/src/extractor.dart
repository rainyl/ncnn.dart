import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'g/ncnn.g.dart' as cg;
import 'mat.dart';
import 'net.dart';
import 'option.dart';

class Extractor extends NativeObject<cg.ncnn_extractor_t> {
  Extractor.fromPointer(super.ptr){
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  @override
  void dispose() {
    finalizer.detach(this);
    cncnn.ncnn_extractor_destroy(ptr);
  }

  factory Extractor.create(Net net) {
    final p = cncnn.ncnn_extractor_create(net.ptr);
    return Extractor.fromPointer(p);
  }

  void setOption(Option option) => cncnn.ncnn_extractor_set_option(ptr, option.ptr);

  int input(String name, Mat mat) {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    final rval = cncnn.ncnn_extractor_input(ptr, cname, mat.ptr);
    calloc.free(cname);
    return rval;
  }

  int inputIndex(int index, Mat mat) => cncnn.ncnn_extractor_input_index(ptr, index, mat.ptr);

  (int, Mat) extract(String name){
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    final pmat = calloc<cg.ncnn_mat_t>();
    final rval = cncnn.ncnn_extractor_extract(ptr, cname, pmat);
    return (rval, Mat.fromPointer(pmat.value));
  }

  (int, Mat) extractIndex(int index){
    final pmat = calloc<cg.ncnn_mat_t>();
    final rval = cncnn.ncnn_extractor_extract_index(ptr, index, pmat);
    return (rval, Mat.fromPointer(pmat.value));
  }

  // TODO
  // factory Datareader.fromStdio(ffi.Pointer<ffi.Pointer<ffi.UnsignedChar>> mem) {
  //   final p = cncnn.ncnn_datareader_create_from_memory(mem);
  //   return Datareader.fromPointer(p);
  // }

  static final finalizer = ncnnFinalizer<cg.ncnn_extractor_t>(cncnn.addresses.ncnn_extractor_destroy);
}
