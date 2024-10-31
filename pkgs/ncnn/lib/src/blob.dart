import 'base.dart';
import 'g/ncnn.g.dart' as cg;

class Blob extends NativeObject<cg.ncnn_blob_t> {
  Blob.fromPointer(super.ptr);

  // static final finalizer = NcnnFinalizer<cg.ncnn_blob_t>(cncnn.addresses.ncnn);
}
