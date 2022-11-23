import 'package:flutter/material.dart';
import 'package:flutter_films/src/providers/films_provider.dart';

//extends from SearchDelegate and implement parent methods
class DataSearch extends SearchDelegate {
  
  FilmsProvider filmsProvider = FilmsProvider();

  final elements = ['Iam first', 'second is me', 'you are the three'];

  final recentElements = ['Recent1', 'ROther Element', 'RSuperElement'];

  String elementSelected = '';

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
    return Center(
        child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.blueAccent,
            child: Text(elementSelected)));
  }

  /** Suggestions (item list) when you are writing */
  @override
  Widget buildSuggestions(BuildContext context) {
    //if the user has enter anything filter among available elements
    final suggestionList = (query.isEmpty)
        ? recentElements
        : elements
            .where((element) =>
                element.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: ((context, index) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(suggestionList[index]),
            onTap: () {
              elementSelected = suggestionList[index];
              showResults(context); // execute action in buildResults
            },
          );
        }));
  }
}
