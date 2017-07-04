import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poems/view/poets_screen.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Lime',
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("Poets"),
      ),
      body: new PoetsList(),
    ),
  ));
}

