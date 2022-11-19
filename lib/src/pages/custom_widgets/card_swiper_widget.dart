import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> elements;

  CardSwiper({required this.elements});

  @override
  Widget build(BuildContext context) {
    //get device screen features
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          //enclose in a ClipRRect to make circular borders
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              "https://via.placeholder.com/350x150",
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: elements.length,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7, //70% of the screen size
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
