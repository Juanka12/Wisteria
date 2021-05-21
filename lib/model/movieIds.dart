class MovieIds {
  final String imdbId;
  // final String facebookId;
  // final String instagramId;
  // final String twitterId;
  final int id;

  MovieIds(this.imdbId,
         this.id,);

  MovieIds.fromJson(Map<String, dynamic> json)
      : imdbId = json["imdb_id"],
        id = json["id"];
}