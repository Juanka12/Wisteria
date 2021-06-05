import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/services/movieAPI.dart';

class ActorMoviesBloc {
  final BehaviorSubject<List<Movie>> _subject = BehaviorSubject<List<Movie>>();

  getCastMovies(int id) async {
    List<Movie> response = await MovieAPI().getCastMovies(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<List<Movie>> get subject => _subject;
}
final actorMoviesBloc = ActorMoviesBloc();