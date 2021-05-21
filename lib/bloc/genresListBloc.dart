import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/genreResponse.dart';
import 'package:wisteria/services/movieAPI.dart';

class GenresListBloc {
  final BehaviorSubject<GenreResponse> _subject = BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await MovieAPI().getGenres();
    _subject.sink.add(response);
  }

  void drain() {
    _subject.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}
final genresListBloc = GenresListBloc();