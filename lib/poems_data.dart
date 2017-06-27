import 'dart:async';

class Poem {
  final String fullName;
  final String text;

  const Poem({this.fullName, this.text});
}


abstract class ContactRepository {
  Future<Poem> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
