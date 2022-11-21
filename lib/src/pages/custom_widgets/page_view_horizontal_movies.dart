import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film_model.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class PageViewHorizontalMovies extends StatelessWidget {
  final List<Film> elements;

  PageViewHorizontalMovies({required this.elements});

  @override
  Widget build(BuildContext context) {
    //get device screen features
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        controller: PageController(
            initialPage: 1, viewportFraction: 0.27 //how many cards in the view
            ),
        pageSnapping:
            false, //conserve the push of the movement,not suddenly stop from one to another
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return elements.map((film) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  image: NetworkImage(film.getPosterUrlPath()),
                  placeholder: AssetImage('assets/loading.gif'),
                  fit: BoxFit.fill //for rounded borders
                  ),
                  ),
                  SizedBox(height: 3.0),
                  Text(film.title!, 
                  overflow: TextOverflow.ellipsis, //to prevent very long text
                  style: Theme.of(context).textTheme.caption)
          ],
        )
      );
    }).toList();
  }
}
