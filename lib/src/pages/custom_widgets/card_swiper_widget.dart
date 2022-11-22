import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film_model.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

// Stateless Widget due to data comes from out
class CardSwiper extends StatelessWidget {
  final List<Film> elements;

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
          return GestureDetector(
            child: _cardImage(index),
            onTap: () {
              Navigator.pushNamed(context, 'details',
                  arguments: elements[index]);
            },
          );
        },
        itemCount: elements.length,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6, //70% of the screen size
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }

  Widget _cardImage(int index) {
    //due to 2 components in the same page want to use hero animation
    //and tag should be unique
    elements[index].uniqueViewId = elements[index].getId() + '_fromMainSwipper';
    return Hero(
      tag: elements[index].getUniqueViewId(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
              image: NetworkImage(elements[index].getPosterUrlPath()),
              placeholder: AssetImage('assets/loading.gif'),
              fit: BoxFit.fill //for rounded borders
              )),
    );
  }
}
