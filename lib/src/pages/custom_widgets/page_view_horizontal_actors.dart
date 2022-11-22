import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film_model.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../models/actor_model.dart';

// Stateless Widget due to data comes from out
class PageViewHorizontalActors extends StatelessWidget {
  final List<Actor> elements;

  final _pageViewController = PageController(
      initialPage: 1, viewportFraction: 0.27 //how many cards in the view
      );

  PageViewHorizontalActors({required this.elements});

  @override
  Widget build(BuildContext context) {
    //get device screen features
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
          controller: _pageViewController,
          pageSnapping:
              false, //conserve the push of the movement,not suddenly stop from one to another
          itemCount: elements.length,
          itemBuilder: (BuildContext context, int index) {
            return _singleActorCard(context, elements[index]);
          }),
    );
  }

  Widget _singleActorCard(BuildContext context, Actor actor) {
    return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  image: NetworkImage(actor.getPosterUrlPath()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.fill //for rounded borders
                  ),
            ),
            SizedBox(height: 3.0),
            Text(actor.name!,
                overflow: TextOverflow.ellipsis, //to prevent very long text
                style: Theme.of(context).textTheme.subtitle2),
            Text(actor.character!,
                overflow: TextOverflow.ellipsis, //to prevent very long text
                style: Theme.of(context).textTheme.caption)
          ],
        ));
  }
}
