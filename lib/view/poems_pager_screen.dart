import 'package:flutter/material.dart';
import 'package:poems/view/poem_screen.dart';

class PoemsPager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PoemsPagerState();
  }
}


class _PoemsPagerState extends State<PoemsPager> {

  /// This controller can be used to programmatically
  /// set the current displayed page
  PageController _pageController;

  _PoemsPagerState();

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