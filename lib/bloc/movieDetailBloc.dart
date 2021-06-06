import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/movieDetail.dart';
import 'package:wisteria/services/firestoreService.dart';
import 'package:wisteria/services/movieAPI.dart';

class MovieDetailBloc {
  final BehaviorSubject<MovieDetail> _subject = BehaviorSubject<MovieDetail>();

  getMovieDetail(int id) async {
    String imdbId = await MovieAPI().getMovieImdbId(id);
    MovieDetail response = await MovieAPI().getMovieDetails(imdbId);
    response.fav = await FirestoreService().isMovieFav(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieDetail> get subject => _subject;
}
final movieDetailBloc = MovieDetailBloc();