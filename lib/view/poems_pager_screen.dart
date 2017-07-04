import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/material.dart';
import 'package:poems/model/poems_data.dart';
import 'package:poems/view/poem_screen.dart';
import 'package:firebase_database/firebase_database.dart';

class PoemsPager extends StatefulWidget {
  final String poetKey;

  PoemsPager({String poetKey}) : poetKey = poetKey;

  @override
  State<StatefulWidget> createState() {
    return new PoemsPagerState(poetKey);
  }
}


class PoemsPagerState extends State<PoemsPager> {
  Poet poet;
  final String poetKey;
  PoetPresenter poetPresenter;

  PoemsPagerState(String poetKey)
      : poetKey = poetKey {
    poetPresenter = new PoetPresenter(this, poetKey);
  }

  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    if (poet == null)
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Random poem"),
        ),
        body: new PageView.builder(
          controller: _pageController,
          onPageChanged: onPageChanged,
          itemBuilder: (BuildContext context, int index) {
            return new PoemWidget(poem: new Poem(text: "", title: ""),);
          },
        ),
      );
    else {
      print("build widget");
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Random poem"),
        ),
        body: new PageView.builder(
          itemCount: poet.poems.length,

          /// Specify the page controller
          controller: _pageController,
          onPageChanged: onPageChanged,
          itemBuilder: (BuildContext context, int index) {
            return new PoemWidget(poem: poet.poems[index],);
          },
        ),
      );
    }
  }


  void onPageChanged(int page) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    poetPresenter.fetchPoems();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void show(Poet poet) {
    setState(() {
      this.poet = poet;
      print("poet = poet");
    });
  }
}

class PoetPresenter {
  final poetKey;
  PoemsPagerState view;

  FirebaseSortedList list;

  PoetPresenter(PoemsPagerState view, String poetKey)
      : poetKey=poetKey,
        view=view;

  void fetchPoems() {
    var q = FirebaseDatabase.instance
        .reference()
        .child("poems/${poetKey}");
    list = new FirebaseSortedList(
      query: q,
      comparator: (a, b) => b.key.compareTo(a.key),
      onValue: onData,
      onChildAdded: nothing,
      onChildChanged: nothing,
      onChildRemoved: nothing,);
  }

  void onData(DataSnapshot event) {
    var map = list.map((s) =>
    new Poem(title: s.value["title"], text: s.value["text"])).toList();
    print(map.toString());
    view.show(new Poet(poems: map));
  }

  void nothing(int i, DataSnapshot d) {}
}