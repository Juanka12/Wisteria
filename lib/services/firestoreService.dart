import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireBase;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/user.dart';
import 'package:wisteria/utils/androidStorage.dart';

class FirestoreService {
  final CollectionReference _users = FirebaseFirestore.instance.collection('users');
  final CollectionReference _favs = FirebaseFirestore.instance.collection('userFavs');
  final CollectionReference _history = FirebaseFirestore.instance.collection('history');

  FirebaseStorage _storage = FirebaseStorage.instance;

  static final FirestoreService _instance = FirestoreService._internalConstructor();

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internalConstructor();

  void createUser(User user) async {
    try {
      await _users.doc(user.uid).set(user.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<User> getUser(String uid) async {
    User user;
    try {
      await _users.doc(uid).get().then((value) {
        if (value.exists) {
          user = User.fromJson(value.data());
        }
      });
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void saveFav(Movie movie) async {
    try {
      var doc = await _favs.doc(fireBase.FirebaseAuth.instance.currentUser.uid).get();
      if (!doc.exists) {
        await _favs.doc(fireBase.FirebaseAuth.instance.currentUser.uid).set({movie.id.toString(): movie.toJson()});
      }else{
        await _favs.doc(fireBase.FirebaseAuth.instance.currentUser.uid).update({movie.id.toString(): movie.toJson()});
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteFav(Movie movie) async {
    try {
      await _favs.doc(fireBase.FirebaseAuth.instance.currentUser.uid).update({movie.id.toString(): FieldValue.delete()});
    } catch (e) {
      print(e);
    }
  }

  void saveHistory(Movie movie) async {
    try {
      var doc = await _history.doc(fireBase.FirebaseAuth.instance.currentUser.uid).get();
      if (!doc.exists) {
        await _history.doc(fireBase.FirebaseAuth.instance.currentUser.uid).set({movie.id.toString(): movie.toJson()});
      }else{
        if (doc.data().length > 19) {
          await _history.doc(fireBase.FirebaseAuth.instance.currentUser.uid).delete();
          await _history.doc(fireBase.FirebaseAuth.instance.currentUser.uid).set({movie.id.toString(): movie.toJson()});
        }else{
          await _history.doc(fireBase.FirebaseAuth.instance.currentUser.uid).update({movie.id.toString(): movie.toJson()});
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Movie>> getFavMovies() async {
    try {
      var response = await _favs.doc(fireBase.FirebaseAuth.instance.currentUser.uid).get();
      List<Movie> listaFavs = [];
      response.data().forEach((key, value) { listaFavs.add(new Movie.fromJson(value));});
      return listaFavs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Movie>> getHistory() async {
    try {
      var response = await _history.doc(fireBase.FirebaseAuth.instance.currentUser.uid).get();
      List<Movie> listaFavs = [];
      response.data().forEach((key, value) { listaFavs.add(new Movie.fromJson(value));});
      return listaFavs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> isMovieFav(int id) async {
    try {
      bool response = false;
      await _favs.doc(fireBase.FirebaseAuth.instance.currentUser.uid).get().then((value) {
        if (value.data().containsKey(id.toString())) {
          response = true;
        }
      });
      return response;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Uint8List> getAvatar() async {
    Uint8List image;
    String user = fireBase.FirebaseAuth.instance.currentUser.uid;
    try {
      await this._storage.ref().child('userAvatars').child('$user.png').getData(10000000).then((value) {
        image = value;
      }).onError((error, stackTrace) async {
        await this._storage.ref().child('userAvatars').child('defaultAvatar.png').getData(10000000).then((value) {
          image = value;
        }).onError((error, stackTrace) {
          image = null;
        });
      });
    } catch (e) {
      print(e);
      image = null;
    }
    return image;
  }

  Future<bool> saveAvatar(File file) async {
    bool boolean = false;
    String user = fireBase.FirebaseAuth.instance.currentUser.uid;
    try {
      await this._storage.ref().child('userAvatars/$user.png').putFile(file).whenComplete(() {
        boolean = true;
      });
      return boolean;
    } catch (e) {
      print(e);
      return boolean;
    }
  }

  Future<List<Uint8List>> getContactsAvatar(List<User> users) async {
    List<Uint8List> image = [];
    for (var i = 0; i < users.length; i++) {
      String id = users[i].uid;
      try {
        await this._storage.ref().child('userAvatars/$id.png').getData(10000000).then((value) {
          image.add(value);
        });
      } catch (e) {
        print(e);
      }
    }
    return image;
  }

  Future<List<User>> getContacts() async {
    List<String> mobileList = await AndroidStorage().getContactNumbers();
    List<User> users = [];
    try {
      await this._users.get().then((value) {
        if (value != null) {
          value.docs.forEach((element) async {
            if (mobileList.contains(element.data()['mobile'])) {
              User user = User.fromJson(element.data());
              users.add(user);
            }
          });
        }
      });
      return users;
    } catch (e) {
      print(e);
    }
  }

  Future<List<Movie>> getFavMoviesbyId(String id) async {
    try {
      var response = await this._favs.doc(id).get();
      List<Movie> listaFavs = [];
      response.data().forEach((key, value) { listaFavs.add(new Movie.fromJson(value));});
      return listaFavs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  void setMobileNumber(String number) async {
    try {
      await this._users.doc(fireBase.FirebaseAuth.instance.currentUser.uid).update({'mobile': number});
    } catch (e) {
    }
  }
}