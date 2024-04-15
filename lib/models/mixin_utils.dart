import 'dart:convert';

mixin JsonAble {
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static List toJsonArray<T extends JsonAble>(List<T> jsonAbleList) {
    if(jsonAbleList.isEmpty) {
      return [];
    }
    return jsonAbleList.map((e) => e.toJson()).toList();
  }
}