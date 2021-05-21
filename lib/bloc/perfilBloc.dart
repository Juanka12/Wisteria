import 'package:firebase_auth/firebase_auth.dart' as fireBase;
import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/user.dart';
import 'package:wisteria/services/firestoreService.dart';

class PerfilBloc {

  final BehaviorSubject<User> _subject = BehaviorSubject<User>();

  getCurrentUser() async {
    User response = await FirestoreService().getUser(fireBase.FirebaseAuth.instance.currentUser.uid);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<User> get subject => _subject;
}
final perfilBloc = PerfilBloc();