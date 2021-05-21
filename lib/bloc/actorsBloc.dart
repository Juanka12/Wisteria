import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/castResponse.dart';
import 'package:wisteria/services/movieAPI.dart';

class ActorsBloc {
  final BehaviorSubject<CastResponse> _subject = BehaviorSubject<CastResponse>();

  getCast(int id) async {
    CastResponse response = await MovieAPI().getCast(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<CastResponse> get subject => _subject;
}
final actorsBloc = ActorsBloc();