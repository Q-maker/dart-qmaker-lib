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