// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'allocator.dart';
import 'base.dart';
import 'g/ncnn.g.dart' as cg;

const int NCNN_MAT_PIXEL_RGB = 1;
const int NCNN_MAT_PIXEL_BGR = 2;
const int NCNN_MAT_PIXEL_GRAY = 3;
const int NCNN_MAT_PIXEL_RGBA = 4;
const int NCNN_MAT_PIXEL_BGRA = 5;
int NCNN_MAT_PIXEL_X2Y(X, Y) => (X | (Y << 16));

class Mat extends NativeObject<cg.ncnn_mat_t> {
  Mat.fromPointer(super.ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  static final finalizer = ncnnFinalizer<cg.ncnn_mat_t>(cncnn.addresses.ncnn_mat_destroy);

  void dispose() {
    finalizer.detach(this);
    cncnn.ncnn_mat_destroy(ptr);
  }

  factory Mat.create() {
    final p = cncnn.ncnn_mat_create();
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_create_1d(int w, ncnn_allocator_t allocator);
  factory Mat.create1D(int w, {int elemsize = 4, int elempack = 1, Allocator? allocator}) {
    final p =
        cncnn.ncnn_mat_create_1d_elem(w, elemsize, elempack, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_create_2d(int w, int h, ncnn_allocator_t allocator);
  factory Mat.create2D(int w, int h, {int elemsize = 4, int elempack = 1, Allocator? allocator}) {
    final p = cncnn.ncnn_mat_create_2d_elem(
        w, h, elemsize, elempack, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_create_3d(int w, int h, int c, ncnn_allocator_t allocator);
  factory Mat.create3D(int w, int h, int c, {int elemsize = 4, int elempack = 1, Allocator? allocator}) {
    final p = cncnn.ncnn_mat_create_3d_elem(
        w, h, c, elemsize, elempack, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_create_4d(int w, int h, int d, int c, ncnn_allocator_t allocator);
  factory Mat.create4D(
    int w,
    int h,
    int d,
    int c, {
    int elemsize = 4,
    int elempack = 1,
    Allocator? allocator,
  }) {
    final p = cncnn.ncnn_mat_create_4d_elem(
        w, h, d, c, elemsize, elempack, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_create_external_1d(int w, void* data, ncnn_allocator_t allocator);
  // ncnn_mat_t ncnn_mat_create_external_2d(int w, int h, void* data, ncnn_allocator_t allocator);
  // ncnn_mat_t ncnn_mat_create_external_3d(int w, int h, int c, void* data, ncnn_allocator_t allocator);
  // ncnn_mat_t ncnn_mat_create_external_4d(int w, int h, int d, int c, void* data, ncnn_allocator_t allocator);
  // ncnn_mat_t ncnn_mat_create_external_1d_elem(int w, void* data, size_t elemsize, int elempack, ncnn_allocator_t allocator);
  // ncnn_mat_t ncnn_mat_create_external_2d_elem(int w, int h, void* data, size_t elemsize, int elempack, ncnn_allocator_t allocator);
  // ncnn_mat_t ncnn_mat_create_external_3d_elem(int w, int h, int c, void* data, size_t elemsize, int elempack, ncnn_allocator_t allocator);
  // ncnn_mat_t ncnn_mat_create_external_4d_elem(int w, int h, int d, int c, void* data, size_t elemsize, int elempack, ncnn_allocator_t allocator);

  // void ncnn_mat_fill_float(ncnn_mat_t mat, float v);
  void fillFloat(double value) => cncnn.ncnn_mat_fill_float(ptr, value);

  // ncnn_mat_t ncnn_mat_clone(const ncnn_mat_t mat, ncnn_allocator_t allocator);
  Mat clone({Allocator? allocator}) {
    final p = cncnn.ncnn_mat_clone(ptr, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_reshape_1d(const ncnn_mat_t mat, int w, ncnn_allocator_t allocator);
  Mat reshape1D(int w, {Allocator? allocator}) {
    final p = cncnn.ncnn_mat_reshape_1d(ptr, w, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_reshape_2d(const ncnn_mat_t mat, int w, int h, ncnn_allocator_t allocator);
  Mat reshape2D(int w, int h, {Allocator? allocator}) {
    final p = cncnn.ncnn_mat_reshape_2d(ptr, w, h, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_reshape_3d(const ncnn_mat_t mat, int w, int h, int c, ncnn_allocator_t allocator);
  Mat reshape3D(int w, int h, int c, {Allocator? allocator}) {
    final p = cncnn.ncnn_mat_reshape_3d(ptr, w, h, c, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_reshape_4d(const ncnn_mat_t mat, int w, int h, int d, int c, ncnn_allocator_t allocator);
  Mat reshape4D(int w, int h, int d, int c, {Allocator? allocator}) {
    final p = cncnn.ncnn_mat_reshape_4d(ptr, w, h, d, c, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // int ncnn_mat_get_dims(const ncnn_mat_t mat);
  int get dims => cncnn.ncnn_mat_get_dims(ptr);

  // int ncnn_mat_get_w(const ncnn_mat_t mat);
  int get w => cncnn.ncnn_mat_get_w(ptr);

  // int ncnn_mat_get_h(const ncnn_mat_t mat);
  int get h => cncnn.ncnn_mat_get_h(ptr);

  // int ncnn_mat_get_d(const ncnn_mat_t mat);
  int get d => cncnn.ncnn_mat_get_d(ptr);

  // int ncnn_mat_get_c(const ncnn_mat_t mat);
  int get c => cncnn.ncnn_mat_get_c(ptr);

  // size_t ncnn_mat_get_elemsize(const ncnn_mat_t mat);
  int get elemsize => cncnn.ncnn_mat_get_elemsize(ptr);

  // int ncnn_mat_get_elempack(const ncnn_mat_t mat);
  int get elempack => cncnn.ncnn_mat_get_elempack(ptr);

  // size_t ncnn_mat_get_cstep(const ncnn_mat_t mat);
  int get cstep => cncnn.ncnn_mat_get_cstep(ptr);

  // void* ncnn_mat_get_data(const ncnn_mat_t mat);
  ffi.Pointer<ffi.Void> get data => cncnn.ncnn_mat_get_data(ptr);

  // void* ncnn_mat_get_channel_data(const ncnn_mat_t mat, int c);
  ffi.Pointer<ffi.Void> getChannelData(int c) => cncnn.ncnn_mat_get_channel_data(ptr, c);

  // ncnn_mat_t ncnn_mat_from_pixels(const unsigned char* pixels, int type, int w, int h, int stride, ncnn_allocator_t allocator);
  factory Mat.fromPixels(List<int> pixels, int type, int w, int h, int stride, {Allocator? allocator}) {
    final ppixels = calloc<ffi.UnsignedChar>(pixels.length);
    ppixels.cast<ffi.Uint8>().asTypedList(pixels.length).setAll(0, pixels);
    final p = cncnn.ncnn_mat_from_pixels(
        ppixels, type, w, h, stride, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_from_pixels_resize(const unsigned char* pixels, int type, int w, int h, int stride, int target_width, int target_height, ncnn_allocator_t allocator);
  factory Mat.fromPixelsResize(
    List<int> pixels,
    int type,
    int w,
    int h,
    int stride,
    int targetWidth,
    int targetHeight, {
    Allocator? allocator,
  }) {
    final ppixels = calloc<ffi.UnsignedChar>(pixels.length);
    ppixels.cast<ffi.Uint8>().asTypedList(pixels.length).setAll(0, pixels);
    final p = cncnn.ncnn_mat_from_pixels_resize(ppixels, type, w, h, stride, targetWidth, targetHeight,
        allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_from_pixels_roi(const unsigned char* pixels, int type, int w, int h, int stride, int roix, int roiy, int roiw, int roih, ncnn_allocator_t allocator);
  factory Mat.fromPixelsRoi(
    List<int> pixels,
    int type,
    int w,
    int h,
    int stride,
    int roix,
    int roiy,
    int roiw,
    int roih, {
    Allocator? allocator,
  }) {
    final ppixels = calloc<ffi.UnsignedChar>(pixels.length);
    ppixels.cast<ffi.Uint8>().asTypedList(pixels.length).setAll(0, pixels);
    final p = cncnn.ncnn_mat_from_pixels_roi(
        ppixels, type, w, h, stride, roix, roiy, roiw, roih, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // ncnn_mat_t ncnn_mat_from_pixels_roi_resize(const unsigned char* pixels, int type, int w, int h, int stride, int roix, int roiy, int roiw, int roih, int target_width, int target_height, ncnn_allocator_t allocator);
  factory Mat.fromPixelsRoiResize(
    List<int> pixels,
    int type,
    int w,
    int h,
    int stride,
    int roix,
    int roiy,
    int roiw,
    int roih,
    int targetWidth,
    int targetHeight, {
    Allocator? allocator,
  }) {
    final ppixels = calloc<ffi.UnsignedChar>(pixels.length);
    ppixels.cast<ffi.Uint8>().asTypedList(pixels.length).setAll(0, pixels);
    final p = cncnn.ncnn_mat_from_pixels_roi_resize(ppixels, type, w, h, stride, roix, roiy, roiw, roih,
        targetWidth, targetHeight, allocator == null ? ffi.nullptr : allocator.ptr);
    return Mat.fromPointer(p);
  }

  // void ncnn_mat_to_pixels(const ncnn_mat_t mat, unsigned char* pixels, int type, int stride);
  ffi.Pointer<ffi.UnsignedChar> toPixels(int type, int stride) {
    final ppixels = calloc<ffi.UnsignedChar>(w * h * c);
    cncnn.ncnn_mat_to_pixels(ptr, ppixels, type, stride);
    return ppixels;
  }

  // void ncnn_mat_to_pixels_resize(const ncnn_mat_t mat, unsigned char* pixels, int type, int target_width, int target_height, int target_stride);

  @override
  String toString() {
    return "Mat(ptr=0x${ptr.address.toRadixString(16)}, dims=$dims, w=$w, h=$h, d=$d, c=$c, elemsize=$elemsize, elempack=$elempack)";
  }
}
