class Movie {
  final int id;
  final double popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;

  Movie(this.id,
         this.popularity,
         this.title,
         this.backPoster,
         this.poster,
         this.overview,);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"].toDouble(),
        title = json["title"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'popularity': popularity,
      'title': title,
      'backdrop_path': backPoster,
      'poster_path': poster,
      'overview': overview,
    };
  }
}