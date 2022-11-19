import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

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
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //we should envelope the Swipper into a Container because swiper needs to now
      //the available space
      width: double.infinity, //all the available width
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "https://via.placeholder.com/350x150",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        layout: SwiperLayout.STACK,
        itemWidth: 200.0, //required due to layout STACK
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
