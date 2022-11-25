import 'package:flutter/material.dart';
import 'package:flutter_films/src/helpers/MouseDraggableScrollBehavior.dart';
import 'package:flutter_films/src/providers/films_provider.dart';
import 'package:flutter_films/src/search/search_delegate.dart';
import 'custom_widgets/card_swiper_widget.dart';
import 'custom_widgets/page_view_horizontal_movies.dart';

class HomePage extends StatelessWidget {
  final FilmsProvider filmProvider = FilmsProvider();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Latest Films"),
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[_nowPlayingSwiper(), _footer(context)]),
          ),
        ));
  }

  Widget _nowPlayingSwiper() {
    return FutureBuilder(
      future: filmProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: (MediaQuery.of(context).size.height * 1.9) / 3,
              child: CardSwiper(elements: snapshot.data));
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
        //margin: EdgeInsets.only(top: 20.0),
        height: (MediaQuery.of(context).size.height) / 3,
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text("Populars", style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: _popularSwiper(),
            ),
          )
          //child: _popularSwiper())
        ]));
  }

  Widget _popularSwiper() {
    //first time call to fill first films
    filmProvider.getMostPopular();
    return StreamBuilder(
      stream: filmProvider.popularFilmsStream, //poiint to the stream
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          //due to the fact By default none of the scrollable widgets are scrolled with mouse on web
          return ScrollConfiguration(
            behavior: MouseDraggableScrollBehavior(),
            child: PageViewHorizontalMovies(
            elements: snapshot.data,
            //send the definition of the callback function that is going to request most films
            requestNextPageCallBackMethod: filmProvider.getMostPopular,
          ),
          );
          // return PageViewHorizontalMovies(
          //   elements: snapshot.data,
          //   //send the definition of the callback function that is going to request most films
          //   requestNextPageCallBackMethod: filmProvider.getMostPopular,
          // );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
