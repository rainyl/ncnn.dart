import 'base.dart';
import 'g/ncnn.g.dart' as cg;
import 'mat.dart';

class ParamDict extends NativeObject<cg.ncnn_paramdict_t> {
  ParamDict.fromPointer(super.ptr) {
    finalizer.attach(this, ptr.cast(), detach: this);
  }

  @override
  void dispose() {
    finalizer.detach(this);
    cncnn.ncnn_paramdict_destroy(ptr);
  }

  factory ParamDict.create() {
    final p = cncnn.ncnn_paramdict_create();
    return ParamDict.fromPointer(p);
  }

  int getType(int id) => cncnn.ncnn_paramdict_get_type(ptr, id);

  T get<T>(int id, T def) {
    if (T == int) {
      return getInt(id, def as int) as T;
    } else if (T == double) {
      return getFloat(id, def as double) as T;
    } else if (T == Mat) {
      return getArray(id, def as Mat) as T;
    } else {
      throw ArgumentError("Unsupported type $T");
    }
  }

  void set<T>(int id, T v) {
    if (T == int) {
      setInt(id, v as int);
    } else if (T == double) {
      setFloat(id, v as double);
    } else if (T == Mat) {
      setArray(id, v as Mat);
    } else {
      throw ArgumentError("Unsupported type $T");
    }
  }

  int getInt(int id, int def) => cncnn.ncnn_paramdict_get_int(ptr, id, def);
  void setInt(int id, int v) => cncnn.ncnn_paramdict_set_int(ptr, id, v);

  double getFloat(int id, double def) => cncnn.ncnn_paramdict_get_float(ptr, id, def);
  void setFloat(int id, double v) => cncnn.ncnn_paramdict_set_float(ptr, id, v);

  Mat getArray(int id, Mat def) => Mat.fromPointer(cncnn.ncnn_paramdict_get_array(ptr, id, def.ptr));
  void setArray(int id, Mat v) => cncnn.ncnn_paramdict_set_array(ptr, id, v.ptr);

  static final finalizer = ncnnFinalizer<cg.ncnn_paramdict_t>(cncnn.addresses.ncnn_paramdict_destroy);
}
