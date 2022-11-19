import 'package:flutter/material.dart';
import 'package:flutter_films/src/providers/films_provider.dart';
import 'custom_widgets/card_swiper_widget.dart';

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
        body: Container(
          child: Column(children: <Widget>[_targetsSwipper()]),
        ));
  }

  Widget _targetsSwipper() {
    return FutureBuilder(
      future: filmProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(elements: snapshot.data);
        } else {
          return Container(
              height: 400.0, 
              child: Center(
                child: CircularProgressIndicator()
                )
                );
        }
      },
    );
    //var films = filmProvider.getNowPlaying();
    //return CardSwiper(elements: films);
  }
}
