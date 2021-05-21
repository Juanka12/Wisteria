import 'package:wisteria/model/movieIds.dart';

class MovieIdsResponse {
  final MovieIds movie;
  final String error;

  MovieIdsResponse(this.movie, this.error);

  MovieIdsResponse.fromJson(Map<String, dynamic> json)
      : movie = MovieIds.fromJson(json),
        error = "";

  MovieIdsResponse.withError(String errorValue)
      : movie = MovieIds("", null),
        error = errorValue;
}