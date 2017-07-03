import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poems/model/poems_data.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(new LimeApp());
}


class LimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Lime',
      home: new PoetsList(),
    );
  }
}

class PoetsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PoetsListState();
  }
}

class _PoetsListState extends State<PoetsList> {

  bool _loading;
  List<Poet> _poets;

  Widget get provideLoadingItem =>
      new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()
          )
      );

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (_loading) {
      widget = provideLoadingItem;
    } else {
      widget = providePoetList(context);
    }

    return widget;
  }

  void showPoets(List<Poet> poets) {
    setState(() {
      _poets = poets;
      _loading = false;
    });
  }

  Widget providePoetList(BuildContext context) {
    final reference = FirebaseDatabase.instance.reference().child('poets');
    return new Column(children: <Widget>[
      new Flexible(

        child: new FirebaseAnimatedList(
          query: reference,
          sort: (a, b) => b.key.compareTo(a.key),
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, DataSnapshot snapshot,
              Animation<double> animation) {
            return new _ContactListItem(
                snapshot: snapshot,
                animation: animation
            );
          },
        )
        ,
      )
    ],

    );
  }
}

class _ContactListItem extends StatelessWidget {
  _ContactListItem({this.snapshot, this.animation});

  final DataSnapshot snapshot;
  final Animation animation;


  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animation, curve: Curves.easeOut
      ),
      child: new Center(
        child: new Text(snapshot.value['name']),
      ),
    );
  }
}
