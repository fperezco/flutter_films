import 'package:flutter/material.dart';

import '../models/film_model.dart';

class FilmDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Film? film = ModalRoute.of(context)!.settings.arguments as Film?;

    if (film == null) return Container();

    return Scaffold(
      body: Text(film.title.toString()),
    );
  }
}
