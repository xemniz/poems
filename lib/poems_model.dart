import 'dart:async';

import 'package:poems/poems_data.dart';

class PoemRepository implements ContactRepository{

  Future<Poem> fetch(){
    return new Future.value(kContacts[0]);
  }

}

const kContacts = const <Poem>[
  const Poem(
      fullName: 'Romain Hoogmoed',
      text:'romain.hoogmoed@example.com'
  ),
  const Poem(
      fullName: 'Emilie Olsen',
      text:'emilie.olsen@example.com'
  )
];