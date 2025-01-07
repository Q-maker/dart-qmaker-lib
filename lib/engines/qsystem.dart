import 'package:qcmcore/io/qcm_package.dart';

class QSystem {


  final IOInterface ioInterface;

  QSystem(this.ioInterface);

  bool exists(String uriString) {
    throw "Not yet implemented";
  }

  bool delete(String uriString) {
    throw "Not yet implemented";
  }

}

final DEFAULT_STREAM_READER = (Stream<List<int>> inputStream) {
  //TODO trouver un moyen de façon synchrone de lire une stream si possible!
  return "";//inputStream.transform(utf8.decoder).join();
};

typedef StreamReader = String Function(Stream<List<int>> inputStream);