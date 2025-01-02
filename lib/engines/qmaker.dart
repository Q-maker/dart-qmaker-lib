import 'dart:io';

import 'package:qcmcore/entities/components.dart';
import 'package:qcmcore/entities/questionnaire.dart';
import 'package:qcmcore/io/qcm_file.dart';
import 'package:qcmcore/models/components.dart';

import '../io/qcm_package.dart';

class Qmaker {

  Future<QcmFile> readUriString(String uri) {
    throw "Not yet implemented";
  }

  Future<QcmFile> readUri(Uri uri) {
    throw "Not yet implemented";
  }

  Future<QcmFile> readFile(File file) {
    throw "Not yet implemented";
  }

  Future<QcmFile> editUriString(String uri) {
    throw "Not yet implemented";
  }

  Future<QcmFile> editUri(Uri uri) {
    throw "Not yet implemented";
  }

  Future<QcmFile> editFile(File file) {
    throw "Not yet implemented";
  }

  Future<QcmFile> newQcmFile(String uriString, {Author? author, String? projectTitle, Config? config, Bundle? summaryExtras, }) {
    throw "Not yet implemented";
  }

}