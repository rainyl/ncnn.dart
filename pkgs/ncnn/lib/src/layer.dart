import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'g/ncnn.g.dart' as cg;

class Layer extends NativeObject<cg.ncnn_layer_t> {
  Layer.fromPointer(super.ptr);

  factory Layer.create() {
    final p = cncnn.ncnn_layer_create();
    return Layer.fromPointer(p);
  }

  factory Layer.fromType(String type) {
    final ctype = type.toNativeUtf8().cast<ffi.Char>();
    final p = cncnn.ncnn_layer_create_by_type(ctype);
    calloc.free(ctype);
    return Layer.fromPointer(p);
  }

  factory Layer.fromTypeIndex(int typeIndex) {
    final p = cncnn.ncnn_layer_create_by_typeindex(typeIndex);
    return Layer.fromPointer(p);
  }

  static final finalizer = ncnnFinalizer<cg.ncnn_layer_t>(cncnn.addresses.ncnn_layer_destroy);

  String get name {
    final p = cncnn.ncnn_layer_get_name(ptr);
    final rval = p.cast<Utf8>().toDartString();
    calloc.free(p);
    return rval;
  }

  int get typeIndex => cncnn.ncnn_layer_get_typeindex(ptr);

  String get type {
    final p = cncnn.ncnn_layer_get_type(ptr);
    final rval = p.cast<Utf8>().toDartString();
    calloc.free(p);
    return rval;
  }

  int get oneBlobOnly => cncnn.ncnn_layer_get_one_blob_only(ptr);
  int get supportInplace => cncnn.ncnn_layer_get_support_inplace(ptr);
  int get supportVulkan => cncnn.ncnn_layer_get_support_vulkan(ptr);
  int get supportPacking => cncnn.ncnn_layer_get_support_packing(ptr);
  int get supportBF16Storage => cncnn.ncnn_layer_get_support_bf16_storage(ptr);
  int get supportImageStorage => cncnn.ncnn_layer_get_support_image_storage(ptr);

  set oneBlobOnly(int enable) => cncnn.ncnn_layer_set_one_blob_only(ptr, enable);
  set supportInplace(int enable) => cncnn.ncnn_layer_set_support_inplace(ptr, enable);
  set supportVulkan(int enable) => cncnn.ncnn_layer_set_support_vulkan(ptr, enable);
  set supportPacking(int enable) => cncnn.ncnn_layer_set_support_packing(ptr, enable);
  set supportBF16Storage(int enable) => cncnn.ncnn_layer_set_support_bf16_storage(ptr, enable);
  set supportImageStorage(int enable) => cncnn.ncnn_layer_set_support_image_storage(ptr, enable);

  static int typeToIndex(String type) {
    final ctype = type.toNativeUtf8().cast<ffi.Char>();
    final rval = cncnn.ncnn_layer_type_to_index(ctype);
    calloc.free(ctype);
    return rval;
  }

  int getBottom(int i) => cncnn.ncnn_layer_get_bottom(ptr, i);
  int getBottomCount() => cncnn.ncnn_layer_get_bottom_count(ptr);
  int getTop(int i) => cncnn.ncnn_layer_get_top(ptr, i);
  int getTopCount() => cncnn.ncnn_layer_get_top_count(ptr);
}
