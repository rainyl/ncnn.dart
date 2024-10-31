import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'datareader.dart';
import 'option.dart';
import 'base.dart';
import 'g/ncnn.g.dart' as cg;

class Net extends NativeObject<cg.ncnn_net_t> {
  Net.fromPointer(super.ptr);

  factory Net.create() {
    final p = cncnn.ncnn_net_create();
    return Net.fromPointer(p);
  }

  Option get option => Option.fromPointer(cncnn.ncnn_net_get_option(ptr));
  set option(Option option) => cncnn.ncnn_net_set_option(ptr, option.ptr);

  void setVulkanDevice(int deviceIndex) => cncnn.ncnn_net_set_vulkan_device(ptr, deviceIndex);

  // TODO
  // ncnn_net_register_custom_layer_by_type(ncnn_net_t net, const char* type, ncnn_layer_creator_t creator, ncnn_layer_destroyer_t destroyer, void* userdata);
  // void registerCustomLayerByType(String type){}

  // TODO
  // ncnn_net_register_custom_layer_by_typeindex(ncnn_net_t net, int typeindex, ncnn_layer_creator_t creator, ncnn_layer_destroyer_t destroyer, void* userdata);

  int loadParam(String path, {bool bin = false}) {
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    final rval = bin ? cncnn.ncnn_net_load_param_bin(ptr, cpath) : cncnn.ncnn_net_load_param(ptr, cpath);
    calloc.free(cpath);
    return rval;
  }

  int loadParamMemory(String mem) {
    final cmem = mem.toNativeUtf8().cast<ffi.Char>();
    final rval = cncnn.ncnn_net_load_param_memory(ptr, cmem);
    calloc.free(cmem);
    return rval;
  }

  int loadParamMemoryBin(Uint8List bytes) {
    final p = calloc<ffi.UnsignedChar>(bytes.length);
    p.cast<ffi.Uint8>().asTypedList(bytes.length).setRange(0, bytes.length, bytes);
    final rval = cncnn.ncnn_net_load_param_bin_memory(ptr, p);
    calloc.free(p);
    return rval;
  }

  int loadParamDatareader(Datareader reader) => cncnn.ncnn_net_load_param_datareader(ptr, reader.ptr);

  int loadParamDatareaderBin(Datareader reader) => cncnn.ncnn_net_load_param_bin_datareader(ptr, reader.ptr);

  int loadModel(String path) {
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    final rval = cncnn.ncnn_net_load_model(ptr, cpath);
    calloc.free(cpath);
    return rval;
  }

  int loadModelBytes(Uint8List bytes) {
    final p = calloc<ffi.UnsignedChar>(bytes.length);
    p.cast<ffi.Uint8>().asTypedList(bytes.length).setRange(0, bytes.length, bytes);
    final rval = cncnn.ncnn_net_load_model_memory(ptr, p);
    calloc.free(p);
    return rval;
  }

  int loadModelDatareader(Datareader reader) => cncnn.ncnn_net_load_model_datareader(ptr, reader.ptr);

  void clear() => cncnn.ncnn_net_clear(ptr);

  int getInputCount() => cncnn.ncnn_net_get_input_count(ptr);
  String getInputName(int index) {
    final p = cncnn.ncnn_net_get_input_name(ptr, index);
    final rval = p.cast<Utf8>().toDartString();
    calloc.free(p);
    return rval;
  }

  int getOutputCount() => cncnn.ncnn_net_get_output_count(ptr);
  String getOutputName(int index) {
    final p = cncnn.ncnn_net_get_output_name(ptr, index);
    final rval = p.cast<Utf8>().toDartString();
    calloc.free(p);
    return rval;
  }

  int getInputIndex(int i) => cncnn.ncnn_net_get_input_index(ptr, i);
  int getOutputIndex(int i) => cncnn.ncnn_net_get_output_index(ptr, i);

  static final finalizer = ncnnFinalizer<cg.ncnn_net_t>(cncnn.addresses.ncnn_net_destroy);
}
