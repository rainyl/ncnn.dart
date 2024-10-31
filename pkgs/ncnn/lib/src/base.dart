import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:logging/logging.dart';

import 'g/ncnn.g.dart' as cg;

abstract class NativeObject<T extends ffi.Pointer> implements ffi.Finalizable {
  NativeObject(this.ptr);

  T ptr;

  bool get isNull => ptr.address == 0;

  void dispose();
}

// finalizers
typedef NativeFinalizerFunctionT<T extends ffi.NativeType>
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(T token)>>;

ffi.NativeFinalizer ncnnFinalizer<T extends ffi.NativeType>(NativeFinalizerFunctionT<T> func) =>
    ffi.NativeFinalizer(func.cast<ffi.NativeFinalizerFunction>());

extension BoolIntExtension on bool {
  int toInt() => this ? 1 : 0;
}

// load native library
ffi.DynamicLibrary loadNativeLibrary(String libName) {
  if (Platform.isIOS) return ffi.DynamicLibrary.process();
  final defaultLibPath = switch (Platform.operatingSystem) {
    "windows" => "$libName.dll",
    "linux" || "android" || "fuchsia" => "lib$libName.so",
    "macos" => "lib$libName.dylib",
    _ => throw UnsupportedError(
        "Platform ${Platform.operatingSystem} not supported",
      )
  };

  final libPath = Platform.environment["NCNN_LIB_PATH"] ?? defaultLibPath;
  if (Platform.isMacOS) {
    try {
      return ffi.DynamicLibrary.open(libPath);
    } catch (e) {
      Logger("ncnn").warning("$e");
      return ffi.DynamicLibrary.process();
    }
  }

  return ffi.DynamicLibrary.open(libPath);
}

final cncnn = cg.NcnnNative(loadNativeLibrary("ncnn"));
