// ignore_for_file: constant_identifier_names

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'g/ncnn.g.dart' as cg;

class Layer extends NativeObject<cg.ncnn_layer_t> {
  Layer.fromPointer(super.ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }
  static final finalizer = ncnnFinalizer<cg.ncnn_layer_t>(cncnn.addresses.ncnn_layer_destroy);

  @override
  void dispose() {
    finalizer.detach(this);
    cncnn.ncnn_layer_destroy(ptr);
  }

  List<int> get bottoms => List.generate(bottomCount, (i) => getBottom(i));
  List<int> get tops => List.generate(topCount, (i) => getTop(i));

  factory Layer.create() {
    final p = cncnn.ncnn_layer_create();
    return Layer.fromPointer(p);
  }

  factory Layer.fromType(LayerType type) {
    final ctype = type.val.toNativeUtf8().cast<ffi.Char>();
    final p = cncnn.ncnn_layer_create_by_type(ctype);
    calloc.free(ctype);
    return Layer.fromPointer(p);
  }

  factory Layer.fromTypeIndex(int typeIndex) {
    final p = cncnn.ncnn_layer_create_by_typeindex(typeIndex);
    return Layer.fromPointer(p);
  }

  String get name => cncnn.ncnn_layer_get_name(ptr).cast<Utf8>().toDartString();

  int get typeIndex => cncnn.ncnn_layer_get_typeindex(ptr);

  String get type => cncnn.ncnn_layer_get_type(ptr).cast<Utf8>().toDartString();

  bool get oneBlobOnly => cncnn.ncnn_layer_get_one_blob_only(ptr) == 1;
  bool get supportInplace => cncnn.ncnn_layer_get_support_inplace(ptr) == 1;
  bool get supportVulkan => cncnn.ncnn_layer_get_support_vulkan(ptr) == 1;
  bool get supportPacking => cncnn.ncnn_layer_get_support_packing(ptr) == 1;
  bool get supportBF16Storage => cncnn.ncnn_layer_get_support_bf16_storage(ptr) == 1;
  bool get supportFP16Storage => cncnn.ncnn_layer_get_support_fp16_storage(ptr) == 1;
  bool get supportImageStorage => cncnn.ncnn_layer_get_support_image_storage(ptr) == 1;

  set oneBlobOnly(bool enable) => cncnn.ncnn_layer_set_one_blob_only(ptr, enable.toInt());
  set supportInplace(bool enable) => cncnn.ncnn_layer_set_support_inplace(ptr, enable.toInt());
  set supportVulkan(bool enable) => cncnn.ncnn_layer_set_support_vulkan(ptr, enable.toInt());
  set supportPacking(bool enable) => cncnn.ncnn_layer_set_support_packing(ptr, enable.toInt());
  set supportBF16Storage(bool enable) => cncnn.ncnn_layer_set_support_bf16_storage(ptr, enable.toInt());
  set supportFP16Storage(bool enable) => cncnn.ncnn_layer_set_support_fp16_storage(ptr, enable.toInt());
  set supportImageStorage(bool enable) => cncnn.ncnn_layer_set_support_image_storage(ptr, enable.toInt());

  static int typeToIndex(LayerType type) {
    final ctype = type.val.toNativeUtf8().cast<ffi.Char>();
    final rval = cncnn.ncnn_layer_type_to_index(ctype);
    calloc.free(ctype);
    return rval;
  }

  int getBottom(int i) => cncnn.ncnn_layer_get_bottom(ptr, i);
  int get bottomCount => cncnn.ncnn_layer_get_bottom_count(ptr);
  int getTop(int i) => cncnn.ncnn_layer_get_top(ptr, i);
  int get topCount => cncnn.ncnn_layer_get_top_count(ptr);
}

enum LayerType {
  AbsVal("AbsVal"),
  ArgMax("ArgMax"),
  BNLL("BNLL"),
  BatchNorm("BatchNorm"),
  Bias("Bias"),
  BinaryOp("BinaryOp"),
  CELU("CELU"),
  Cast("Cast"),
  Clip("Clip"),
  Concat("Concat"),
  Convolution("Convolution"),
  Convolution1D("Convolution1D"),
  Convolution3D("Convolution3D"),
  ConvolutionDepthWise("ConvolutionDepthWise"),
  ConvolutionDepthWise1D("ConvolutionDepthWise1D"),
  ConvolutionDepthWise3D("ConvolutionDepthWise3D"),
  CopyTo("CopyTo"),
  Crop("Crop"),
  CumulativeSum("CumulativeSum"),
  Deconvolution("Deconvolution"),
  Deconvolution1D("Deconvolution1D"),
  Deconvolution3D("Deconvolution3D"),
  DeconvolutionDepthWise("DeconvolutionDepthWise"),
  DeconvolutionDepthWise1D("DeconvolutionDepthWise1D"),
  DeconvolutionDepthWise3D("DeconvolutionDepthWise3D"),
  DeepCopy("DeepCopy"),
  DeformableConv2D("DeformableConv2D"),
  Dequantize("Dequantize"),
  DetectionOutput("DetectionOutput"),
  Diag("Diag"),
  Dropout("Dropout"),
  ELU("ELU"),
  Einsum("Einsum"),
  Eltwise("Eltwise"),
  Embed("Embed"),
  Erf("Erf"),
  Exp("Exp"),
  ExpandDims("ExpandDims"),
  Flatten("Flatten"),
  Fold("Fold"),
  GELU("GELU"),
  GLU("GLU"),
  GRU("GRU"),
  Gemm("Gemm"),
  GridSample("GridSample"),
  GroupNorm("GroupNorm"),
  HardSigmoid("HardSigmoid"),
  HardSwish("HardSwish"),
  InnerProduct("InnerProduct"),
  Input("Input"),
  InstanceNorm("InstanceNorm"),
  Interp("Interp"),
  LRN("LRN"),
  LSTM("LSTM"),
  LayerNorm("LayerNorm"),
  Log("Log"),
  MVN("MVN"),
  MatMul("MatMul"),
  MemoryData("MemoryData"),
  Mish("Mish"),
  MultiHeadAttention("MultiHeadAttention"),
  Noop("Noop"),
  Normalize("Normalize"),
  PReLU("PReLU"),
  PSROIPooling("PSROIPooling"),
  Packing("Packing"),
  Padding("Padding"),
  Permute("Permute"),
  PixelShuffle("PixelShuffle"),
  Pooling("Pooling"),
  Pooling1D("Pooling1D"),
  Pooling3D("Pooling3D"),
  Power("Power"),
  PriorBox("PriorBox"),
  Proposal("Proposal"),
  Quantize("Quantize"),
  RMSNorm("RMSNorm"),
  RNN("RNN"),
  ROIAlign("ROIAlign"),
  ROIPooling("ROIPooling"),
  ReLU("ReLU"),
  Reduction("Reduction"),
  Reorg("Reorg"),
  Requantize("Requantize"),
  Reshape("Reshape"),
  SELU("SELU"),
  SPP("SPP"),
  Scale("Scale"),
  Shrink("Shrink"),
  ShuffleChannel("ShuffleChannel"),
  Sigmoid("Sigmoid"),
  Slice("Slice"),
  Softmax("Softmax"),
  Softplus("Softplus"),
  Split("Split"),
  Squeeze("Squeeze"),
  StatisticsPooling("StatisticsPooling"),
  Swish("Swish"),
  TanH("TanH"),
  Threshold("Threshold"),
  Tile("Tile"),
  UnaryOp("UnaryOp"),
  Unfold("Unfold"),
  YoloDetectionOutput("YoloDetectionOutput"),
  Yolov3DetectionOutput("Yolov3DetectionOutput"),
  INVALID("INVALID"),
  ;

  static LayerType fromVal(String val) {
    for (final type in LayerType.values) {
      if (type.val == val) return type;
    }
    return LayerType.INVALID;
  }

  final String val;
  const LayerType(this.val);
}
