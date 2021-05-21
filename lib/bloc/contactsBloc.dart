import 'dart:typed_data';

import 'package:rxdart/rxdart.dart';
import 'package:wisteria/model/user.dart';
import 'package:wisteria/services/firestoreService.dart';

class ContactsBloc {
  final BehaviorSubject<List<User>> _subject = BehaviorSubject<List<User>>();
  final BehaviorSubject<List<Uint8List>> _subjectAvatars = BehaviorSubject<List<Uint8List>>();

  getContacts() async {
    List<User> response = await FirestoreService().getContacts();
    List<Uint8List> avatars = await FirestoreService().getContactsAvatar(response);
    _subject.sink.add(response);
    _subjectAvatars.sink.add(avatars);
  }

  void drain() {
    _subject.add(null);
    _subjectAvatars.add(null);
  }

  dispose() async {
    await _subject.drain();
    _subject.close();
    await _subjectAvatars.drain();
    _subject.close();
  }

  BehaviorSubject<List<User>> get subject => _subject;
  BehaviorSubject<List<Uint8List>> get subjectAvatars => _subjectAvatars;
}
final contactsBloc = ContactsBloc();