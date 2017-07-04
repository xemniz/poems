import 'package:flutter/material.dart';
import 'package:poems/model/poems_data.dart';


class PoemWidget extends StatelessWidget {
  final Poem poem;

  PoemWidget({ Key key, Poem poem })
      : poem = poem,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return providePoemItemWidget(context);
  }

  SingleChildScrollView providePoemItemWidget(BuildContext context) =>
      (new SingleChildScrollView(
          padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: new Center(
              child: new RichText(
                textScaleFactor: 1.4,
                text: new TextSpan(
                  style: DefaultTextStyle
                      .of(context)
                      .style,
                  children: <TextSpan>[
                    new TextSpan(text: poem.title,
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(text: poem.text),
                  ],
                ),
              )
          )
      ));
}
