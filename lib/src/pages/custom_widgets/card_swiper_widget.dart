import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> elements;

  CardSwiper({required this.elements});

  @override
  Widget build(BuildContext context) {

    
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
      ),
    );
  }
}
