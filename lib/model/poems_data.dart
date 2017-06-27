import 'dart:async';

class Poem {
  final String author;
//  final String title;
  final String text;

  const Poem({this.author, this.text});
}


abstract class PoemsRepository {
  Future<Poem> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
