import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'dart:core' as core;
import 'dart:math' as Math;

import 'exceptions.dart';
import 'mixin_utils.dart';


class Pair<T, Y> {
  final T first;
  final Y second;

  Pair(this.first, this.second);

  Pair.from(Pair<T, Y> pair)
      : this(pair.first, pair.second);
}

class Triplet<T, Y, Z> {
  final T first;
  final Y second;
  final Z third;

  Triplet(this.first, this.second, this.third);

  Triplet.from(Triplet<T, Y, Z> triplet)
      : this(triplet.first, triplet.second, triplet.third);
}

class ContentLengthDescription {
  static const int DEFAULT_SIZE_DESCRIPTION_NUMBER_ROUNDING = 2;
  static const core.String DEFAULT_UNIT_BYTES = "bytes";
  static const core.String DEFAULT_UNIT_KILO_BYTES = "Kb";
  static const core.String DEFAULT_UNIT_MEGA_BYTES = "Mb";
  static const core.String DEFAULT_UNIT_GIGA_BYTES = "Gb";
  static const core.String DEFAULT_UNIT_TERA_BYTES = "Tb";
  num _value = 0;
  core.String _unit = DEFAULT_UNIT_BYTES;
  int _digitAfterDot = 2;
  String _byteUnit = DEFAULT_UNIT_BYTES;
  String _kiloByteUnit = DEFAULT_UNIT_KILO_BYTES;
  String _megaByteUnit = DEFAULT_UNIT_MEGA_BYTES;
  String _gigaByteUnit = DEFAULT_UNIT_GIGA_BYTES;
  String _teraByteUnit = DEFAULT_UNIT_TERA_BYTES;

  num get value {
    if (_value > 0) {
      num pow = Math.pow(10, _digitAfterDot);
      return ((_value * pow).toInt()) / pow;
    }
    return _value;
  }

  int get digitAfterDot => _digitAfterDot;

  String get byteUnit => _byteUnit;

  String get kiloByteUnit => _kiloByteUnit;

  String get megaByteUnit => _megaByteUnit;

  String get gigaByteUnit => _gigaByteUnit;

  String get teraByteUnit => _teraByteUnit;

  core.String get unit => _unit;

  ContentLengthDescription convertTo(String unit) {
    num byteValue = _value;
    if (_unit == gigaByteUnit) {
      byteValue = _value * 1024 * 1024 * 1024;
    } else if (_unit == megaByteUnit) {
      byteValue = _value * 1024 * 1024;
    } else if (unit == kiloByteUnit) {
      byteValue = _value * 1024;
    } else {
      throw new IllegalArgumentException(
          "The submited unit is outside the boundary given when initializing data descriptions: byteUnit, kiloByteUnit, ...");
    }
    return new ContentLengthDescription(byteValue, unit,
        byteUnit: _byteUnit,
        kiloByteUnit: _kiloByteUnit,
        megaByteUnit: _megaByteUnit,
        gigaByteUnit: _gigaByteUnit,
        teraByteUnit: _teraByteUnit,
        digitAfterDot: _digitAfterDot);
  }

  @override
  core.String toString() {
    if (value == value.toInt()) {
      return '${value.toInt()} $unit';
    } else {
      return '$value $unit';
    }
  }

  ContentLengthDescription(this._value, this._unit,
      {int digitAfterDot = 2,
        String byteUnit = DEFAULT_UNIT_BYTES,
        String kiloByteUnit = DEFAULT_UNIT_KILO_BYTES,
        String megaByteUnit = DEFAULT_UNIT_MEGA_BYTES,
        String gigaByteUnit = DEFAULT_UNIT_GIGA_BYTES,
        teraByteUnit = DEFAULT_UNIT_TERA_BYTES}) {
    this._digitAfterDot = digitAfterDot;
    this._byteUnit = byteUnit;
    this._kiloByteUnit = kiloByteUnit;
    this._megaByteUnit = megaByteUnit;
    this._gigaByteUnit = gigaByteUnit;
  }

  factory ContentLengthDescription.fromByteCount(num byteCount,
      {int digitAfterDot = 2,
        String byteUnit = DEFAULT_UNIT_BYTES,
        String kiloByteUnit = DEFAULT_UNIT_KILO_BYTES,
        String megaByteUnit = DEFAULT_UNIT_MEGA_BYTES,
        String gigaByteUnit = DEFAULT_UNIT_GIGA_BYTES,
        teraByteUnit = DEFAULT_UNIT_TERA_BYTES}) {
    num value;
    String unit;
    if (byteCount >= 1073741824) {
      value = (((((byteCount /
          (1024 * 1024 * 1024)) /** * 100*/) /*as int*/)) /*/ 100*/);
      unit = gigaByteUnit;
    } else if (byteCount >= 1024 * 1024) {
      value =
      (((((byteCount / (1024 * 1024)) /** * 100)*/) /*as int*/)) /*/ 100*/);
      unit = megaByteUnit;
    } else if (byteCount >= 1024) {
      value = (((((byteCount / (1024)) /** * 100)*/) /*as int*/)) /*/ 100*/);
      unit = kiloByteUnit;
    } else {
      unit = byteUnit;
      value = byteCount;
    }
    return new ContentLengthDescription(value, unit,
        digitAfterDot: digitAfterDot,
        byteUnit: byteUnit,
        kiloByteUnit: kiloByteUnit,
        megaByteUnit: megaByteUnit,
        gigaByteUnit: gigaByteUnit,
        teraByteUnit: teraByteUnit);
  }

}

class Link with JsonAble{
  String? rel;
  List<String> methods = [];
  String href;
  Link(this.rel, this.href, this.methods);

  Link.fromJson(Map<String, dynamic> json) : this(json["rel"], json["href"], (json["methods"] as List).map((e) => e.toString()).toList());

  Link? fromJsonString(String? jsonString) {
    if(jsonString?.isNotEmpty != true) {
      return null;
    }
    Map<String, dynamic> jsonMap = jsonDecode(jsonString!);
    return Link.fromJson(jsonMap);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      "methods": methods,
      "href": href,
    };
    if(rel !=null) {
      jsonMap["rel"] = rel;
    }
    return jsonMap;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static List<Link> listFromJsonArray(List jsonArray) {
    List<Link> list = [];
    for(var jsonMap in jsonArray) {
      list.add(Link.fromJson(jsonMap));
    }
    return list;
  }
}

class MapWrapper<T, Y> with MapBase<T, Y> {
  final Map<T, Y> _data;
  MapWrapper(this._data);

  @override
  Y? operator [](Object? key) {
    return _data[key];
  }

  @override
  void operator []=(T key, Y value) {
    _data[key] = value;
  }

  @override
  void clear() {
   _data.clear();
  }

  @override
  Iterable<T> get keys => _data.keys;

  @override
  Y? remove(Object? key) {
    return _data.remove(key);
  }

}

typedef Callable<Output> = Output Function();

typedef FutureCallable<Output> = Future<Output> Function();

typedef Provider<Input, Output> = Output Function(Input input);

typedef Decoder<Input, Output> = Output Function(Input input);

typedef Encoder<Input, Output> = Output Function(Input input);
