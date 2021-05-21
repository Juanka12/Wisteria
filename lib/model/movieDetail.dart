class MovieDetail {
  final String id;
  final String genres;
  final String releaseDate;
  final String duration;
  final String imdbRate;
  final String director;
  final String writer;
  String metacriticRate;
  bool fav;

  MovieDetail(this.id,
         this.genres,
         this.releaseDate,
         this.duration,
         this.imdbRate,
         this.director,
         this.writer,);

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json["imdbID"],
        genres = json["Genre"],
        releaseDate = json["Year"],
        duration = json["Runtime"],
        imdbRate = json["imdbRating"],
        director = json["Director"],
        writer = json["Writer"];
}