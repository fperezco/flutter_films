import 'package:flutter/material.dart';
import 'package:flutter_films/src/providers/films_provider.dart';
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
          actions: [IconButton(icon: Icon(Icons.search), onPressed: null)],
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[_nowPlayingSwiper(), _footer(context)]),
          ),
        ));
  }

  Widget _nowPlayingSwiper() {
    return FutureBuilder(
      future: filmProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(elements: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        child: Column(children: [
          Text("Populars", style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 10.0,
          ),
          _popularSwiper()
        ]));
  }

  Widget _popularSwiper() {
    return FutureBuilder(
      future: filmProvider.getMostPopular(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return PageViewHorizontalMovies(elements: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
