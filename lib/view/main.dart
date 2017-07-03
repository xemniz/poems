import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poems/model/poems_data.dart';
import 'package:poems/model/poems_model.dart';

void main() {
  runApp(new LimeApp());
}


class LimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Lime',
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}


class _MainPageState extends State<MainPage> {

  /// This controller can be used to programmatically
  /// set the current displayed page
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Random poem"),
      ),
      body: new PageView.builder(

        /// Specify the page controller
        controller: _pageController,
        onPageChanged: onPageChanged,
        itemBuilder: (BuildContext context, int index) {
          return new PoemWidget();
        },
      ),
    );
  }


  void onPageChanged(int page) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

class PoemWidget extends StatefulWidget {
  PoemWidget({ Key key }) : super(key: key);
  final poemsRepository = new FireBasePoemsRepository("esenin");

  @override
  _PoemState createState() => new _PoemState(poemsRepository);
}

class _PoemState extends State <PoemWidget> {
  FireBasePoemsRepository _poemsRepository;

  bool _isSearching;
  Poem _poem;
  double _textScale = 1.4;

  _PoemState(FireBasePoemsRepository poemsRepository) {
    _poemsRepository = poemsRepository;
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;

    _poemsRepository.fetch()
        .then((contacts) => onLoadContactsComplete(contacts))
        .catchError((onError) {
      print(onError);
      onLoadContactsError();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (_isSearching) {
      widget = provideLoadingItem;
    } else {
      widget = providePoemItemWidget(context);
    }

    return widget;
  }

  Center get provideLoadingItem =>
      new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()
          )
      );

  SingleChildScrollView providePoemItemWidget(BuildContext context) =>
      (new SingleChildScrollView(
          padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: new GestureDetector(
//              onScaleUpdate: (details) => setTextScale(details.scale),
              child: new Center(
                  child: new RichText(
                    textScaleFactor: _textScale,
                    text: new TextSpan(
                      style: DefaultTextStyle
                          .of(context)
                          .style,
                      children: <TextSpan>[
                        new TextSpan(text: _poem.author,
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                        new TextSpan(text: _poem.text),
                      ],
                    ),
                  )
              ))
      ));

  void onLoadContactsComplete(Poem poem) {
    setState(() {
      _poem = poem;
      _isSearching = false;
    });
  }

  void onLoadContactsError() {

  }

  setTextScale(double scale) {
    setState(() {
      _textScale = scale;
    });
  }
}