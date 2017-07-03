import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:poems/model/poems_data.dart';

class FireBasePoemsRepository implements PoemsRepository {
  List<Poem> poems;
  var rng = new Random();

  FireBasePoemsRepository(String poet) {
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(
        "poems");
    DatabaseReference poetRef = ref.child(poet);
    poetRef.once().then((data) => print(data));
  }

  Poem getRandomPoem() {
    return new Poem();
  }

  Future<Poem> fetch() {
    return new Future.value(getRandomPoem());
  }
}