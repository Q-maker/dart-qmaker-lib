class BaseException implements Exception {
  final String? _message;

  BaseException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }

  String? get message => _message;
}

class TaggedException extends BaseException {
  final String? tag;
  final dynamic target;
  TaggedException(String message, {this.tag, this.target}): super(message);
}

class OutOfBoundException extends BaseException {
  List _boundList;
  int _index;

  OutOfBoundException(this._index, this._boundList, [String? message])
      : super(message){
    //TODO implementer un defaul message
  }

  List get boundList => _boundList;

  int get index => _index;
}

class IllegalArgumentException extends TaggedException {
  IllegalArgumentException(String message, {String? tag}) : super(message, tag: tag);
}

class IllegalOperationResultException extends TaggedException {
  IllegalOperationResultException(String message, {String? tag}) : super(message, tag: tag);
}

class IllegalStateException extends TaggedException {
  IllegalStateException(String message, {String? tag, dynamic target}) : super(message, tag: tag, target: target);
}

class UnsupportedOperationException extends IllegalStateException {
  UnsupportedOperationException(String message, {String? tag}) : super(message, tag: tag);
}

class ConcurrentOperationException extends IllegalStateException {
  ConcurrentOperationException(String message, {String? tag}) : super(message, tag: tag);
}

class ResourceNotFoundException extends TaggedException {

  final dynamic _target;

  ResourceNotFoundException(this._target, String message, {String? tag}) : super(message, tag: tag);

  String get target => _target;

}

class NoResultFoundException extends IllegalStateException {
  final dynamic target;

  NoResultFoundException(String message , {this.target, String? tag}) : super(message, tag: tag);
}

class OperationCanceledException extends TaggedException {
  OperationCanceledException(String message, {String? tag}) : super(message, tag: tag);
}

class AuthenticationMissingException extends IllegalStateException {
  AuthenticationMissingException(String message) : super(message);
}