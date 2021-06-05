import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/castDetail.dart';
import 'package:wisteria/services/movieAPI.dart';

class ActorDetailBloc {
  final BehaviorSubject<CastDetail> _subject = BehaviorSubject<CastDetail>();

  getCastDetail(int id) async {
    CastDetail response = await MovieAPI().getCastDetail(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<CastDetail> get subject => _subject;
}
final actorDetailBloc = ActorDetailBloc();