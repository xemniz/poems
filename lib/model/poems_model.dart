import 'dart:async';
import 'dart:math';
import 'package:poems/model/esenin_poems.dart';
import 'package:poems/model/poems_data.dart';

class EseninPoemsRepository implements PoemsRepository {
  List<Poem> poems;
  var rng = new Random();

  EseninPoemsRepository() {
    poems = esenin.split(DIVIDER).map((it) =>
    new Poem(author: "Есенин", text: it)).toList();
  }

  Poem getRandomPoem() {
    return poems[rng.nextInt(poems.length)];
  }

  Future<Poem> fetch() {
    return new Future.value(getRandomPoem());
  }

}