import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'g/ncnn.g.dart' as cg;

class Datareader extends NativeObject<cg.ncnn_datareader_t> {
  Datareader.fromPointer(super.ptr){
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  @override
  void dispose() {
    finalizer.detach(this);
    cncnn.ncnn_datareader_destroy(ptr);
  }

  factory Datareader.create() {
    final p = cncnn.ncnn_datareader_create();
    return Datareader.fromPointer(p);
  }
  factory Datareader.fromMemory(Uint8List mem) {
    // TODO: how to free this?
    final pmem = calloc<ffi.Pointer<ffi.UnsignedChar>>()..value = calloc<ffi.UnsignedChar>(mem.length);
    pmem.value.cast<ffi.Uint8>().asTypedList(mem.length).setAll(0, mem);
    final p = cncnn.ncnn_datareader_create_from_memory(pmem);
    return Datareader.fromPointer(p);
  }

  factory Datareader.fromFile(String filePath) {
    final bytes = File(filePath).readAsBytesSync();
    return Datareader.fromMemory(bytes);
  }

  static final finalizer = ncnnFinalizer<cg.ncnn_datareader_t>(cncnn.addresses.ncnn_datareader_destroy);
}
