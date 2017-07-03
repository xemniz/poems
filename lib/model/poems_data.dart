import 'dart:async';

class Poem {
  final String title;
  final String text;
  final String year;

  const Poem({this.title, this.text, this.year});
}

class Poet {
  final String name;
  final int century;
  final List<Poem> poems;

  const Poet({this.name, this.century, this.poems});
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
