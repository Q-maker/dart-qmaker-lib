import 'package:qcmcore/models/mixin_utils.dart';
import 'package:qcmcore/models/model_utils.dart';
import 'package:qcmcore/utils/toolkit.dart' as ToolKits;

class Bundle extends MapWrapper<String, dynamic> with JsonAble{
  Bundle({Map<String, dynamic>? data}):super(data ?? Map<String, dynamic>());

  T opt<T>(String key, T defaultValue) {
    return this[key] ?? defaultValue;
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

}