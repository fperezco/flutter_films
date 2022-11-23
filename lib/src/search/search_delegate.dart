import 'package:flutter/material.dart';
import 'package:flutter_films/src/providers/films_provider.dart';

import '../models/film_model.dart';

//extends from SearchDelegate and implement parent methods
class DataSearch extends SearchDelegate {
  FilmsProvider filmsProvider = FilmsProvider();

  final elements = ['Iam first', 'second is me', 'you are the three'];

  final recentElements = ['Recent1', 'ROther Element', 'RSuperElement'];

  Film? elementSelected = null;

  /** Actions of the navBar, for example the X to close or cancel */
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query =
            '', //due to we have the internally field 'query' with the string searched
      )
    ];
  }

  /** Icon on the left side of the navBar */
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null); //predefined close on the SearchDelegate
      },
    );
  }

  /** Builder to build results on the list */
  @override
  Widget buildResults(BuildContext context) {
    Navigator.pushNamed(context, 'details', arguments: elementSelected);
    return Container();
    // return Center(
    //     child: Container(
    //         height: 100.0,
    //         width: 100.0,
    //         color: Colors.blueAccent,
    //         child: Text(elementSelected)));
  }

  /** Suggestions (item list) when you are writing */
  @override
  Widget buildSuggestions(BuildContext context) {
    //if the user has enter anything filter among available elements

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: filmsProvider.filmsByQuery(query),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (snapshot.hasData) {
          final films = snapshot.data;
          return ListView.builder(
              itemCount: films!.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: FadeInImage(
                      image: NetworkImage(films[index].getPosterUrlPath()),
                      placeholder: AssetImage('assets/no-image.jpg')),
                  title: Text(films[index].getTitle()),
                  subtitle: Text("(" + films[index].getReleasedYear() + ")"),
                  onTap: () {
                    //in this case we don't use the showResults due to
                    //we want to close and move to another screen
                    close(context, null); //we just close no result to show due to we go next screen
                    films[index].uniqueViewId = "";
                    Navigator.pushNamed(context, 'details', arguments: films[index]);
                  },
                );
              }));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    // final suggestionList = (query.isEmpty)
    //     ? recentElements
    //     : elements
    //         .where((element) =>
    //             element.toLowerCase().contains(query.toLowerCase()))
    //         .toList();

    // return ListView.builder(
    //     itemCount: suggestionList.length,
    //     itemBuilder: ((context, index) {
    //       return ListTile(
    //         leading: Icon(Icons.movie),
    //         title: Text(suggestionList[index]),
    //         onTap: () {
    //           elementSelected = suggestionList[index];
    //           showResults(context); // execute action in buildResults
    //         },
    //       );
    //     }));
  }
}
