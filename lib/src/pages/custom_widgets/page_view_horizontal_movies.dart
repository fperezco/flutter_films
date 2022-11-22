import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film_model.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

// Stateless Widget due to data comes from out
class PageViewHorizontalMovies extends StatelessWidget {
  final List<Film> elements;
  //callback function required
  final Function requestNextPageCallBackMethod;

  final _pageViewController = PageController(
      initialPage: 1, viewportFraction: 0.27 //how many cards in the view
      );

  PageViewHorizontalMovies(
      {required this.elements, required this.requestNextPageCallBackMethod});

  @override
  Widget build(BuildContext context) {
    //get device screen features
    final _screenSize = MediaQuery.of(context).size;

    //listener to manage PageView
    //when the end is near => request more films
    _pageViewController.addListener((() {
      if (_pageViewController.position.pixels >=
          _pageViewController.position.maxScrollExtent - 100) {
        requestNextPageCallBackMethod();
      }
    }));

    return Container(
      height: _screenSize.height * 0.3,
      //child: PageView(
      //   controller: _pageViewController,
      //   pageSnapping:
      //       false, //conserve the push of the movement,not suddenly stop from one to another
      //   children: _cards(context),
      // ),
      //move to PageView.builder to save memory due to only render on demands
      child: PageView.builder(
          controller: _pageViewController,
          pageSnapping:
              false, //conserve the push of the movement,not suddenly stop from one to another
          itemCount: elements.length,
          itemBuilder: (BuildContext context, int index) {
            return _singleCard(context, elements[index]);
          }),
    );
  }

  Widget _singleCard(BuildContext context, Film film) {
    final card = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  image: NetworkImage(film.getPosterUrlPath()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.fill //for rounded borders
                  ),
            ),
            SizedBox(height: 3.0),
            Text(film.title!,
                overflow: TextOverflow.ellipsis, //to prevent very long text
                style: Theme.of(context).textTheme.caption)
          ],
        ));

    return GestureDetector(
      child: card,
      onTap: () {
        print("Id film tapped: ${film.id}");
        Navigator.pushNamed(context, 'details',arguments: film);
      },
    );
  }

//PageView not builder version
  // List<Widget> _cards(BuildContext context) {
  //   return elements.map((film) {
  //     return Container(
  //         margin: EdgeInsets.only(right: 15.0),
  //         child: Column(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(20.0),
  //               child: FadeInImage(
  //                   image: NetworkImage(film.getPosterUrlPath()),
  //                   placeholder: AssetImage('assets/loading.gif'),
  //                   fit: BoxFit.fill //for rounded borders
  //                   ),
  //             ),
  //             SizedBox(height: 3.0),
  //             Text(film.title!,
  //                 overflow: TextOverflow.ellipsis, //to prevent very long text
  //                 style: Theme.of(context).textTheme.caption)
  //           ],
  //         ));
  //   }).toList();
  // }

}
