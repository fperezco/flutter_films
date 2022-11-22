class Actors {
  List<Actor> items = [];

  Actors();

  Actors.fromJsonList(List<dynamic> sourceJson) {
    if (sourceJson == null) return;
    for (var item in sourceJson) {
      // a raw json film
      final actor = Actor.fromJsonMap(item);
      items.add(actor);
    }
  }
}

class Actor {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  Actor.fromJsonMap(Map<String, dynamic> sourceJson) {
    adult = sourceJson['adult'];
    gender = sourceJson['gender'];
    id = sourceJson['id'];
    knownForDepartment = sourceJson['known_for_department'];
    name = sourceJson['name'];
    originalName = sourceJson['original_name'];
    popularity = sourceJson['popularity'];
    profilePath = sourceJson['profile_path'];
    castId = sourceJson['castId'];
    character = sourceJson['character'];
    creditId = sourceJson['creditId'];
    order = sourceJson['order'];
  }

  String getPosterUrlPath() {
    if (profilePath != null) {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
    return "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png";
  }
}
