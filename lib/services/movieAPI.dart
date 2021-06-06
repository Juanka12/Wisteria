import 'package:dio/dio.dart';
import 'package:wisteria/model/castDetail.dart';
import 'package:wisteria/model/castResponse.dart';
import 'package:wisteria/model/genreResponse.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/movieDetailResponse.dart';
import 'package:wisteria/model/movieIdsResponse.dart';
import 'package:wisteria/model/moviesResponse.dart';

class MovieAPI {
  final String _apiKey = "4d9eb1e1a38c5254e6ae54d958c58a47";
  final String _movieUrl = "https://api.themoviedb.org/3";

  final Dio _dio = Dio();

  static final MovieAPI _instance = MovieAPI._internalConstructor();

  factory MovieAPI() {
    return _instance;
  }

  MovieAPI._internalConstructor();

  Future<MovieResponse> getMovies() async {
    String popularMoviesUrl = "$_movieUrl/movie/now_playing";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
      "page": 1
    };
    try {
      Response response = await _dio.get(popularMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return MovieResponse.withError("$e");
    }
  }

  Future<MovieResponse> getMoviesbySearch(String title) async {
    String searchMovieUrl = "$_movieUrl/search/movie";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
      "query": title,
      "page": 1,
      "include_adult": false
    };
    try {
      Response response = await _dio.get(searchMovieUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return MovieResponse.withError("$e");
    }
  }

  Future<MovieResponse> getMoviesbyGenre(int id) async {
    String moviesUrl = "$_movieUrl/discover/movie";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
      "page": 1,
      "with_genres": id,
    };
    try {
      Response response = await _dio.get(moviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return MovieResponse.withError("$e");
    }
  }

  Future<GenreResponse> getGenres() async {
    String genresUrl = "$_movieUrl/genre/movie/list";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
    };
    try {
      Response response = await _dio.get(genresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return GenreResponse.withError("$e");
    }
  }

  Future<MovieResponse> getUpcomingMovies() async {
    String upcomingMoviesUrl = "$_movieUrl/movie/upcoming";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
      "page": 1
    };
    try {
      Response response = await _dio.get(upcomingMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return MovieResponse.withError("$e");
    }
  }

  Future<MovieDetailResponse> getMovieDetails(String id) async {
    String movieDetailUrl = "https://www.omdbapi.com/";
    var params = {
      "apikey": 'fd781264',
      "i": id,
    };
    try {
      Response response = await _dio.get(movieDetailUrl, queryParameters: params);
      List<dynamic> ratings = response.data["Ratings"];
      MovieDetailResponse detail = MovieDetailResponse.fromJson(response.data);
      if (ratings.length >= 3) {
        detail.setMetacriticRate(ratings[2]["Value"]);
      }else{
        detail.setMetacriticRate("N/A");
      }
      return detail;
    } catch (e) {
      print(e);
      return MovieDetailResponse.withError("$e");
    }
  }

  Future<String> getMovieImdbId(int id) async {
    String movieIdUrl = "$_movieUrl/movie/$id/external_ids";
    var params = {
      "api_key": _apiKey,
    };
    try {
      Response response = await _dio.get(movieIdUrl, queryParameters: params);
      return MovieIdsResponse.fromJson(response.data).movie.imdbId;
    } catch (e) {
      print(e);
      return MovieIdsResponse.withError("$e").movie.imdbId;
    }
  }

  Future<CastResponse> getCast(int id) async {
    String castUrl = "$_movieUrl/movie/$id/credits";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
    };
    try {
      Response response = await _dio.get(castUrl, queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (e) {
      print(e);
      return CastResponse.withError("$e");
    }
  }

  Future<CastDetail> getCastDetail(int id) async {
    String castDetailUrl = "$_movieUrl/person/$id";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
    };
    try {
      Response response = await _dio.get(castDetailUrl, queryParameters: params);
      return CastDetail.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Movie>> getCastMovies(int id) async {
    List<Movie> movies;
    String castMovieUrl = "$_movieUrl/person/$id/movie_credits";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
    };
    try {
      Response response = await _dio.get(castMovieUrl, queryParameters: params);
      movies = (response.data["cast"] as List).map((i) => new Movie.fromJson(i)).toList();
      return movies;
    } catch (e) {
      print(e);
    }
  }

  Future<String> getTrailer(int id) async {
    String trailerUrl = "$_movieUrl/movie/$id/videos";
    var params = {
      "api_key": _apiKey,
      "language": 'es-ES',
    };
    try {
      Response response = await _dio.get(trailerUrl, queryParameters: params);
      if ((response.data["results"] as List).isEmpty) {
        params = {
          "api_key": _apiKey,
          "language": 'en-US',
        };
        response = await _dio.get(trailerUrl, queryParameters: params);
      }
      return response.data["results"][0]["key"];
    } catch (e) {
      print(e);
    }
  }
}