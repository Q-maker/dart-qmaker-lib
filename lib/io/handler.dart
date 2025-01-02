class IOHandler {

}

class QWriter {

}

class QEntry {
  final Uri uri;
  final IOHandler ioHandler;
  int length = 0;

  QEntry(this.uri, this.ioHandler);
  
}