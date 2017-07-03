import 'dart:async';
import 'dart:math';
import 'package:poems/model/esenin_poems.dart';
import 'package:poems/model/poems_data.dart';
import 'package:firebase_database/firebase_database.dart';         //new
import 'package:firebase_database/ui/firebase_animated_list.dart';

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

class FireBasePoemsRepository implements PoemsRepository {
  List<Poem> poems;
  var rng = new Random();

  FireBasePoemsRepository(String poet) {
    DatabaseReference ref = FirebaseDatabase.instance.reference().child("poems");
    DatabaseReference poetRef = ref.child(poet);
    poetRef.once().then((data) => print(data));
  }

  Poem getRandomPoem() {
    return new Poem(text: "", author: "");
  }

  Future<Poem> fetch() {
    return new Future.value(getRandomPoem());
  }
}