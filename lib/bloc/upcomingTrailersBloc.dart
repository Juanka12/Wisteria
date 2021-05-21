import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/services/movieAPI.dart';

class UpcomingTrailersBloc {
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await MovieAPI().getUpcomingMovies();
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
final upcomingTrailersBloc = UpcomingTrailersBloc();