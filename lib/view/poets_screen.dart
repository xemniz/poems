import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:poems/model/poems_data.dart';
import 'package:poems/view/poems_pager_screen.dart';

class PoetsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PoetsListState();
  }
}

class _PoetsListState extends State<PoetsList> {

  bool _loading;

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
      _loading = false;
    });
  }

  Widget providePoetList(BuildContext context) {
    final reference = FirebaseDatabase.instance.reference().child('poets');
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white12,
      ),
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
              query: reference,
              sort: (a, b) => b.key.compareTo(a.key),
              reverse: true,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animation) {
                return new _ContactListItem(
                    snapshot: snapshot,
                    animation: animation
                );
              },
            ),
          )
        ],

      ),
    );
  }
}

class _ContactListItem extends StatelessWidget {
  _ContactListItem({this.snapshot, this.animation});

  final DataSnapshot snapshot;
  final Animation animation;


  @override
  Widget build(BuildContext context) {
    return
      new GestureDetector(
        onTap: () =>
            Navigator.push(
                context, new MaterialPageRoute(
                builder: (_) => new PoemsPager(poetKey: snapshot.key))
            ),
        child: new Container(
          decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(
                    color: Colors.black38
                )
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          height: 48.0,
          child: new Text(
            snapshot.value['name'],
            style: Theme
                .of(context)
                .primaryTextTheme
                .title
                .copyWith(color: Colors.black54),
          ),
        ),
      );
  }
}
