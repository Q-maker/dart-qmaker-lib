import 'dart:io';

import 'package:qcmcore/engines/qsystem.dart';
import 'package:qcmcore/entities/components.dart';
import 'package:qcmcore/entities/questionnaire.dart';
import 'package:qcmcore/io/qcm_file.dart';
import 'package:qcmcore/models/components.dart';
import 'package:qcmcore/utils/components.dart';

import '../io/qcm_package.dart';

class Qmaker {
  static const List<QSystemProvider> _qSystemProviders = [];
  static const Map<String, RatingTypeHandler> _nameRatingTypeHandles = {};

  List<QSystemProvider> get qSystemProviders => List.unmodifiable(_qSystemProviders);

  Future<QcmFile> readUriString(String uri) {
    throw "Not yet implemented";
  }

  Future<QcmFile> readUri(Uri uri) {
    throw "Not yet implemented";
  }

  Future<QcmFile> readFile(File file) {
    throw "Not yet implemented";
  }

  Future<QcmFile> editUriString(String uri, {Author? author, String? ownerPassword, int? permission}) {
    throw "Not yet implemented";
  }

  Future<QcmFile> editUri(Uri uri, {Author? author, String? ownerPassword, int? permission}) {
    throw "Not yet implemented";
  }

  Future<QcmFile> editFile(File file, {Author? author, String? ownerPassword, int? permission}) {
    throw "Not yet implemented";
  }

  Future<QcmFile> newQcmFile(String uriString, {Author? author, String? projectTitle, Config? config, Bundle? summaryExtras, String? projectId}) {
    throw "Not yet implemented";
  }

  QSystem? resolveQSystem(String uriString) {
    throw "Not yet implemented";
  }

  IOInterface? resolveIOInterface(String uriString) {
    QSystem? qSystem = resolveQSystem(uriString);
    return qSystem?.ioInterface;
  }

  bool exist(String uriString) {
    QSystem? qSystem = resolveQSystem(uriString);
    return qSystem?.exists(uriString) ?? false;
  }

  bool delete(String uriString) {
    QSystem? qSystem = resolveQSystem(uriString);
    return qSystem?.delete(uriString) ?? false;
  }

  bool unregisterQSystemProvider(QSystemProvider provider) {
    return _qSystemProviders.remove(provider);
  }

  bool registerQSystemProvider(QSystemProvider provider) {
    if(_qSystemProviders.contains(provider)) {
      return false;
    }
    _qSystemProviders.add(provider);
    return true;
  }

  List<bool> registerQSystemProviders(List<QSystemProvider> providers) {
    List<bool> output = [];
    for(QSystemProvider provider in providers) {
      output.add(registerQSystemProvider(provider));
    }
    return output;
  }

}

typedef QSystemProvider = QSystem Function(String uriString);