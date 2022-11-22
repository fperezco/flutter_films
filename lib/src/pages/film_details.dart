import 'package:flutter/material.dart';
import 'package:flutter_films/src/pages/custom_widgets/page_view_horizontal_actors.dart';

import '../models/film_model.dart';
import '../providers/films_provider.dart';

class FilmDetails extends StatelessWidget {
  final FilmsProvider filmProvider = FilmsProvider();

  @override
  Widget build(BuildContext context) {
    final Film? film = ModalRoute.of(context)!.settings.arguments as Film?;

    if (film == null) return Container();

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppBar(film),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: 10.0),
          _posterTitle(context, film),
          _filmDescription(film),
          SizedBox(height: 15.0),
          _actorsPageView(film)
        ]))
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
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          background: FadeInImage(
              image: NetworkImage(film.getBackgroundUrlPath()),
              placeholder: AssetImage('assets/loading.gif'),
              fit: BoxFit.cover),
        ));
  }

  Widget _posterTitle(BuildContext context, Film film) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
        Hero(
          tag: film.getUniqueViewId(), //asociated with the previous tag in the home page
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(film.getPosterUrlPath()),
              height: 150.0,
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(film.getTitle(),
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis),
            Text(film.getOriginalTitle(),
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis),
            Row(
              children: [
                Icon(Icons.star_border),
                Text(film.getVoteAverage(),
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            )
          ]),
        )
      ]),
    );
  }

  Widget _filmDescription(Film film) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        margin: EdgeInsets.only(top: 10.0),
        child: Text(film.getOverview(), textAlign: TextAlign.justify));
  }

  Widget _actorsPageView(Film film) {
    return FutureBuilder(
      future: filmProvider.getActorsByMovie(film),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return PageViewHorizontalActors(elements: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
