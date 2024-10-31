// ignore_for_file: constant_identifier_names

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'g/ncnn.g.dart' as cg;
import 'mat.dart';
import 'option.dart';

const int NCNN_BORDER_CONSTANT = 0;
const int NCNN_BORDER_REPLICATE = 1;
const int NCNN_BORDER_REFLECT = 2;
const int NCNN_BORDER_TRANSPARENT = -233;

String version() => cncnn.ncnn_version().cast<Utf8>().toDartString();

// void ncnn_copy_make_border(const ncnn_mat_t src, ncnn_mat_t dst, int top, int bottom, int left, int right, int type, float v, const ncnn_option_t opt);
Mat copyMakeBorder(
  Mat src,
  int top,
  int bottom,
  int left,
  int right,
  int type,
  double v,
  Option opt, {
  Mat? dst,
}) {
  dst ??= Mat.create();
  cncnn.ncnn_copy_make_border(src.ptr, dst.ptr, top, bottom, left, right, type, v, opt.ptr);
  return dst;
}

// void ncnn_copy_make_border_3d(const ncnn_mat_t src, ncnn_mat_t dst, int top, int bottom, int left, int right, int front, int behind, int type, float v, const ncnn_option_t opt);
Mat copyMakeBorder3d(
  Mat src,
  int top,
  int bottom,
  int left,
  int right,
  int front,
  int behind,
  int type,
  double v,
  Option opt, {
  Mat? dst,
}) {
  dst ??= Mat.create();
  cncnn.ncnn_copy_make_border_3d(src.ptr, dst.ptr, top, bottom, left, right, front, behind, type, v, opt.ptr);
  return dst;
}

// void ncnn_copy_cut_border(const ncnn_mat_t src, ncnn_mat_t dst, int top, int bottom, int left, int right, const ncnn_option_t opt);
Mat copyCutBorder(
  Mat src,
  int top,
  int bottom,
  int left,
  int right,
  Option opt, {
  Mat? dst,
}) {
  dst ??= Mat.create();
  cncnn.ncnn_copy_cut_border(src.ptr, dst.ptr, top, bottom, left, right, opt.ptr);
  return dst;
}

// void ncnn_copy_cut_border_3d(const ncnn_mat_t src, ncnn_mat_t dst, int top, int bottom, int left, int right, int front, int behind, const ncnn_option_t opt);
Mat copyCutBorder3d(
  Mat src,
  int top,
  int bottom,
  int left,
  int right,
  int front,
  int behind,
  Option opt, {
  Mat? dst,
}) {
  dst ??= Mat.create();
  cncnn.ncnn_copy_cut_border_3d(src.ptr, dst.ptr, top, bottom, left, right, front, behind, opt.ptr);
  return dst;
}

// void ncnn_draw_rectangle_c1(unsigned char* pixels, int w, int h, int rx, int ry, int rw, int rh, unsigned int color, int thickness);
// Mat drawRectangleC1(
//   Mat mat,
//   int w,
//   int h,
//   int rx,
//   int ry,
//   int rw,
//   int rh,
//   int color,
//   int thickness,
// ) {
//   cncnn.ncnn_draw_rectangle_c1(mat.toPixels(mat., stride), w, h, rx, ry, rw, rh, color, thickness);
//   return mat;
// }

// void ncnn_draw_rectangle_c2(unsigned char* pixels, int w, int h, int rx, int ry, int rw, int rh, unsigned int color, int thickness);
// void ncnn_draw_rectangle_c3(unsigned char* pixels, int w, int h, int rx, int ry, int rw, int rh, unsigned int color, int thickness);
// void ncnn_draw_rectangle_c4(unsigned char* pixels, int w, int h, int rx, int ry, int rw, int rh, unsigned int color, int thickness);

// void ncnn_draw_text_c1(unsigned char* pixels, int w, int h, const char* text, int x, int y, int fontpixelsize, unsigned int color);
// void ncnn_draw_text_c2(unsigned char* pixels, int w, int h, const char* text, int x, int y, int fontpixelsize, unsigned int color);
// void ncnn_draw_text_c3(unsigned char* pixels, int w, int h, const char* text, int x, int y, int fontpixelsize, unsigned int color);
// void ncnn_draw_text_c4(unsigned char* pixels, int w, int h, const char* text, int x, int y, int fontpixelsize, unsigned int color);

// void ncnn_draw_circle_c1(unsigned char* pixels, int w, int h, int cx, int cy, int radius, unsigned int color, int thickness);
// void ncnn_draw_circle_c2(unsigned char* pixels, int w, int h, int cx, int cy, int radius, unsigned int color, int thickness);
// void ncnn_draw_circle_c3(unsigned char* pixels, int w, int h, int cx, int cy, int radius, unsigned int color, int thickness);
// void ncnn_draw_circle_c4(unsigned char* pixels, int w, int h, int cx, int cy, int radius, unsigned int color, int thickness);

// void ncnn_draw_line_c1(unsigned char* pixels, int w, int h, int x0, int y0, int x1, int y1, unsigned int color, int thickness);
// void ncnn_draw_line_c2(unsigned char* pixels, int w, int h, int x0, int y0, int x1, int y1, unsigned int color, int thickness);
// void ncnn_draw_line_c3(unsigned char* pixels, int w, int h, int x0, int y0, int x1, int y1, unsigned int color, int thickness);
// void ncnn_draw_line_c4(unsigned char* pixels, int w, int h, int x0, int y0, int x1, int y1, unsigned int color, int thickness);

// void ncnn_mat_substract_mean_normalize(ncnn_mat_t mat, const float* mean_vals, const float* norm_vals);

// void ncnn_convert_packing(const ncnn_mat_t src, ncnn_mat_t* dst, int elempack, const ncnn_option_t opt);

// void ncnn_flatten(const ncnn_mat_t src, ncnn_mat_t* dst, const ncnn_option_t opt);
Mat flatten(Mat src, {Option? opt}) {
  opt ??= Option.create();
  final p = calloc<cg.ncnn_mat_t>();
  cncnn.ncnn_flatten(src.ptr, p, opt.ptr);
  return Mat.fromPointer(p.value);
}
