import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/services/movieAPI.dart';

class MoviesbyGenreBloc {
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMoviesbyGenre(int id) async {
    MovieResponse response = await MovieAPI().getMoviesbyGenre(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}
final moviesbyGenreBloc = MoviesbyGenreBloc();