import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/services/firestoreService.dart';

class HistorialBloc {
  final BehaviorSubject<List<Movie>> _subject = BehaviorSubject<List<Movie>>();

  getHistory() async {
    List<Movie> response = await FirestoreService().getHistory();
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
final historialBloc = HistorialBloc();