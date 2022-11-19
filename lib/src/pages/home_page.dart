import 'package:flutter/material.dart';
import 'custom_widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Latest Films"),
          backgroundColor: Colors.indigo,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: null)],
        ),
        body: Container(
          child: Column(children: <Widget>[_targetsSwipper()]),
        ));
  }

  Widget _targetsSwipper() {
    return CardSwiper(elements: [1,2,3,4,5]);
  }
}
