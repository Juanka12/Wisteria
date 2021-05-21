import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/movieDetailResponse.dart';
import 'package:wisteria/services/firestoreService.dart';
import 'package:wisteria/services/movieAPI.dart';

class MovieDetailBloc {
  final BehaviorSubject<MovieDetailResponse> _subject = BehaviorSubject<MovieDetailResponse>();

  getMovieDetail(int id) async {
    String imdbId = await MovieAPI().getMovieImdbId(id);
    MovieDetailResponse response = await MovieAPI().getMovieDetails(imdbId);
    response.movieDetail.fav = await FirestoreService().isMovieFav(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieDetailResponse> get subject => _subject;
}
final movieDetailBloc = MovieDetailBloc();