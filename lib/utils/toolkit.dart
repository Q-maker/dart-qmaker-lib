import 'dart:async';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:qcmcore/models/exceptions.dart';
import 'package:qcmcore/models/mixin_utils.dart';
import 'package:qcmcore/models/model_utils.dart';

const String API_WEB_SERVER_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
const List<String> PASSWORD_PROPOSITION_CHAR = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F"
];

bool isEmpty(String? value) {
  return value == null || value.isEmpty;
}

bool isNotEmpty(String? value) {
  return !isEmpty(value);
}

bool isArrayContains(List? list, dynamic target) {
  return list != null && list.isNotEmpty && list.contains(target);
}

String buildExtensionRegexMatcher(List<String> extension) {
  String regex = "";
  for (int i = 0; i < extension.length; i++) {
    regex += "((?i)(^.+(\\.${extension[i]})\$))";
    if (i < extension.length - 1) {
      regex += "|";
    }
  }
  return regex;
}

int generateNumber(int length) {
  String number = "";
  Random random =  Random();
  int index;
  for (int i = 0; i < 16; i++) {
    index = random.nextInt(10);
    number += "$index";
  }
  return int.tryParse(number) ?? 0;
}

String generateNonce(int length) {
  String nonce = "";
  Random random =  Random();
  int index;
  for (int i = 0; i < 16; i++) {
    index = random.nextInt(PASSWORD_PROPOSITION_CHAR.length - 1);
    nonce += PASSWORD_PROPOSITION_CHAR[index];
  }
  return nonce;
}

bool isAbsolutePath(String? path) {
  return path != null && path.startsWith("/");
}

String toAbsolutePath(String parentPath, String? path) {
  if (!isAbsolutePath(parentPath)) {
    throw  IllegalArgumentException(
        "the first parameter @parentPath should be an absolute path.");
  } else if (isAbsolutePath(path)) {
    throw  IllegalArgumentException(
        "the second parameter @path can't be an absolute path.");
  }
  String absolutePath = parentPath;
  return absolutePath +
      (path != null ? (absolutePath.endsWith("/") ? "" : "/") + path : "");
}

//String toAbsolutePath(String parentPath, String childPath) {
//  if (childPath == null) {
//    return parentPath;
//  }
//  return parentPath.replaceFirst(RegExp(r"/$"), "") +
//      (childPath != null
//          ? "/" + childPath.replaceFirst(RegExp(r"^/"), "")
//          : "");
//}

String regularizePath(String? path) {
  if (isEmpty(path)) {
    return "";
  }
  String out = path!.startsWith("/") ? path.replaceFirst("/", "") : path;
  return out.trim();
}

String regularizeURLPath(String? path) {
  String out = regularizePath(path);
  try {
    out = Uri.encodeFull(out).replaceAll("+", "%20").replaceAll("%2F", "/");
  } catch (e) {
    out = out.replaceAll("\\s", "%20");
  }
  return out.trim();
}

Triplet<int, int, num> getFieldFilledMetrics(
    dynamic object, List<String> fieldNames) {
  int filled = 0;
  String jsonString = jsonEncode(object);
  Map<String, dynamic> map = jsonDecode(jsonString);
  List<MapEntry<String, dynamic>> mapEntries = map.entries.toList();
  for (MapEntry<String, dynamic> entry in mapEntries) {
    if (fieldNames.contains(entry.key) &&
        entry.value != null &&
        !isEmpty(entry.value.toString())) {
      filled++;
    }
  }
  num percentage = filled * 100;
  percentage = percentage / fieldNames.length;
  return Triplet(fieldNames.length, filled, percentage);
}

String formatToDateTime(DateTime date) {
  return DateFormat(API_WEB_SERVER_DATE_FORMAT).format(date);
}

DateTime parseDateTime(String dateTime) {
  return DateFormat(API_WEB_SERVER_DATE_FORMAT).parse(dateTime);
}

DateTime? tryToParseDateTime(String? dateTime, {DateTime? defaultValue}) {
  try {
    if(dateTime?.isEmpty == true) {
      return defaultValue;
    }
    return DateFormat(API_WEB_SERVER_DATE_FORMAT).parse(dateTime!);
  } catch(e) {
    return defaultValue;
  }
}

String dateNowFormatted() {
  return DateFormat(API_WEB_SERVER_DATE_FORMAT).format(DateTime.now());
}

Map<String, String> toUrlFormEncoding(Map<String, dynamic> input, {String? prefixKey}) {
  Map<String, String> queries = {};
  for(var entry in input.entries) {
    if(entry.value is Map) {
      String key = entry.key;
      String recomputedPrefixKey = prefixKey == null? key : "$prefixKey[$key]";
      queries.addAll(toUrlFormEncoding(entry.value, prefixKey: recomputedPrefixKey));
    } else {
      if(prefixKey?.isNotEmpty ==  true) {
        queries["$prefixKey[${entry.key}]"] = "${entry.value}";
      } else {
        queries[entry.key] = "${entry.value}";
      }
    }
  }
  return queries;
}

List toJsonArray<T>(List<T> itemList) {
  List jsonArray = [];
  Map<String, dynamic> jsonValue;
  for(T item in itemList) {
    jsonValue = item is JsonAble? item.toJson() : jsonDecode(jsonEncode(item));
    jsonArray.add(jsonValue);
  }
  return jsonArray;

}

bool isValidDate(String dateString, {String format = "dd/MM/yyyy"}) {
  try {
    DateFormat(format).parseStrict(dateString);
    return true;
  } catch (e) {
    return false;
  }
}


String dateFormat(String date,{String dateFormat = "dd-MM-yyyy",String? locale}) {
  return DateFormat(dateFormat,locale)
      .format(DateFormat("yyyy-MM-ddTHH:mm:ss").parse(date,true));
}

formBuilderValidatorsMatchIMask(String pattern, {String? errorMessage}) {
  return ((valueCandidate) => true == valueCandidate?.isNotEmpty &&
          !RegExp(pattern).hasMatch(valueCandidate!.replaceAll(" ", ""))
      ? errorMessage ?? "Regex does not match"
      : null);
}

extension StringExtensions on String {
  String capitalize() { 
    return "${this[0].toUpperCase()}${substring(1)}"; 
  } 
}

extension DateTimeExtension on DateTime {
  bool isDate(String dayName,{String? locale}){
    return DateFormat('EEEE',locale).format(this).toLowerCase() == dayName.toLowerCase();
  }

  bool isAfterOrEqual(DateTime other) {
    return isAtSameMomentAs(other) || isAfter(other);
  }

  bool isBeforeOrEqual(DateTime other) {
    return isAtSameMomentAs(other) || isBefore(other);
  }
  
  bool isBetween({required DateTime from, required DateTime to}) {
    return isAfterOrEqual(from) && isBeforeOrEqual(to);
  }
  
  bool isBetweenExclusive({required DateTime from, required DateTime to}) {
    return isAfter(from) && isBefore(to);
  }
}
extension DurationExtension on Duration {
   String formatDuration() {
    var seconds = inSeconds;
    final days = seconds~/Duration.secondsPerDay;
    seconds -= days*Duration.secondsPerDay;
    final hours = seconds~/Duration.secondsPerHour;
    seconds -= hours*Duration.secondsPerHour;
    final minutes = seconds~/Duration.secondsPerMinute;
    seconds -= minutes*Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0){
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    if(hours <= 0 && minutes <= 0) {
      tokens.add('${seconds}s');
    }
    
    return tokens.join(':');
  }
}
  
String formatDuration(Duration d) {
  var seconds = d.inSeconds;
  final days = seconds ~/ Duration.secondsPerDay;
  seconds -= days * Duration.secondsPerDay;
  final hours = seconds ~/ Duration.secondsPerHour;
  seconds -= hours * Duration.secondsPerHour;
  final minutes = seconds ~/ Duration.secondsPerMinute;
  seconds -= minutes * Duration.secondsPerMinute;

  final List<String> tokens = [];
  if (days != 0) {
    tokens.add('${days} jours');
  }
  if (tokens.isNotEmpty || hours != 0) {
    tokens.add('${hours} heures');
  }
  if (tokens.isNotEmpty || minutes != 0) {
    tokens.add('${minutes} minutes');
  }

  return tokens.join(' ');
}
  