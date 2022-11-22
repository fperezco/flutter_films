class Films {
  List<Film> items = [];

  Films();

  Films.fromJsonList(List<dynamic> sourceJson) {
    if (sourceJson == null) return;
    for (var item in sourceJson) {
      // a raw json film
      final film = Film.fromJsonMap(item);
      items.add(film);
    }
  }
}

class Film {
  String? uniqueViewId;
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  String? originalLanguage;
  int? id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Film(
      {required this.adult,
      required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  Film.fromJsonMap(Map<String, dynamic> sourceJson) {
    adult = sourceJson['adult'];
    backdropPath = sourceJson['backdrop_path'];
    genreIds = sourceJson['genre_ids'].cast<int>();
    id = sourceJson['id'];
    originalLanguage = sourceJson['original_language'];
    originalTitle = sourceJson['original_title'];
    overview = sourceJson['overview'];
    popularity = sourceJson['popularity'] / 1;
    posterPath = sourceJson['poster_path'];
    releaseDate = sourceJson['release_date'];
    title = sourceJson['title'];
    video = sourceJson['video'];
    voteAverage = sourceJson['vote_average'] / 1; //due to double
    voteCount = sourceJson['vote_count'];
  }

  String getPosterUrlPath() {
    if (posterPath != null) {
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    }
    return "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png";
  }

  String getBackgroundUrlPath() {
    if (backdropPath != null) {
      return "https://image.tmdb.org/t/p/w500/$backdropPath";
    }
    return "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png";
  }

  String getTitle() {
    return this.title.toString();
  }

  String getOriginalTitle() {
    return this.originalTitle.toString();
  }

  String getVoteAverage() {
    return this.voteAverage.toString();
  }

  String getOverview() {
    return this.overview.toString();
  }

  String getId() {
    return this.id.toString();
  }

    String getUniqueViewId() {
    return this.uniqueViewId.toString();
  }
}
