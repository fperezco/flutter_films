import 'package:flutter/material.dart';

import '../models/film_model.dart';

class FilmDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Film? film = ModalRoute.of(context)!.settings.arguments as Film?;

    if (film == null) return Container();

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppBar(film),
      ],
    ));
  }

  Widget _createAppBar(Film film) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          film.getTitle(),
          style: TextStyle(color:Colors.white,fontSize: 16.0),
      ),
      background: FadeInImage(
        image: NetworkImage(film.getBackgroundUrlPath()),
        placeholder: AssetImage('assets/loading.gif')),
    ));
  }
}
