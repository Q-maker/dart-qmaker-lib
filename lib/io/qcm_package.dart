import 'package:qcmcore/io/handler.dart';
import 'package:qcmcore/io/qcm_file.dart';

abstract class  QPackage with QFile{

}

class Resource extends Section with QFile{
  static const String TYPE_SOUNDS = "sounds";
  static const String TYPE_IMAGES = "images";
  static const String TYPE_ANIMATIONS = "animations";
  static const String TYPE_VIDEOS = "videos";
  static const String TYPE_FONTS = "fonts";

  static const String DIR_SOUNDS = TYPE_SOUNDS + "/";
  static const String DIR_IMAGES = TYPE_IMAGES + "/";
  static const String DIR_ANIMATIONS = TYPE_ANIMATIONS + "/";
  static const String DIR_VIDEOS = TYPE_VIDEOS + "/";
  static const String DIR_FONTS = TYPE_FONTS + "/";

  static const String DIR_RES_SOUNDS = QcmFile.DIR_RES + DIR_SOUNDS;
  static const String DIR_RES_IMAGES = QcmFile.DIR_RES + DIR_IMAGES;
  static const String DIR_RES_ANIMATIONS = QcmFile.DIR_RES + DIR_ANIMATIONS;
  static const String DIR_RES_VIDEOS = QcmFile.DIR_RES + DIR_VIDEOS;
  static const String DIR_RES_FONTS = QcmFile.DIR_RES + DIR_FONTS;

  static const String type = QFile.TYPE_RESOURCE;
}

abstract class Section {
  
}

mixin QFile{
  static const String SCHEME = "qfile";
  static const  String TYPE_SUMMARY = "qcmsum";
  static const String TYPE_ARCHIVE = "qcm";
  static const String TYPE_SECTION = "section";
  static const String TYPE_BUNDLE = "qcmx";
  static const String TYPE_BINARY = "qcmbin";
  static const String TYPE_RESOURCE = "res";
  static const String TYPE_QXT = "qxt";
}


abstract class IOInterface {
  int FLAG_SUPPORTS_OPERATION_WRITE = 1 << 1;
  int FLAG_SUPPORTS_OPERATION_DELETE = 1 << 2;
  int FLAG_SUPPORTS_OPERATION_CREATE = 1 << 3;
  int FLAG_SUPPORTS_OPERATION_READ = 1 << 4;
  int FLAG_SUPPORTS_OPERATION_RENAME = 1 << 6;
  int FLAG_SUPPORTS_OPERATION_COPY = 1 << 7;
  int FLAG_SUPPORTS_OPERATION_MOVE = 1 << 8;
  int FLAG_SUPPORTS_OPERATION_REMOVE = 1 << 10;
  int FLAG_SUPPORTS_OPERATION_PERSIST_ACCESS = 1 << 11;

  int getContentLength(Uri uri);

  int getLastModifiedAt(Uri uri);

  Stream<List<int>> openInputStream(Uri uri);

  QWriter getWriter(QPackage qPackage);

  bool delete(String uri);

  bool exists(String uri);

  bool moveTo(String uri, String destinationUri);

  int getSupportedOperationFlags(String uriString);
}