import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wisteria/model/user.dart' as modelUser;
import 'package:wisteria/services/firestoreService.dart';

class AuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  static final AuthService _instance = AuthService._internalConstructor();

  factory AuthService() {
    return _instance;
  }

  AuthService._internalConstructor();

  Future<String> registerEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await FirestoreService().createUser(modelUser.User(uid:userCredential.user.uid,email:email));
      modelUser.User newUser = await FirestoreService().getUser(userCredential.user.uid);
      if (newUser == null) {
        FirestoreService().createUser(modelUser.User.withName(uid:userCredential.user.uid,name:'',surname:'',email:email,mobile: ''));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password is to weak';
      } else if (e.code == 'email-already-in-use') {
        return 'This email is registered';
      }
    } catch (e) {
      return e;
    }
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found';
      }else if (e.code == 'wrong-password') {
        return 'Wrong password';
      }
    }
  }

  Future<String> signInGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await _auth.signInWithCredential(credential);
    var user = FirebaseAuth.instance.currentUser;
    modelUser.User newUser = await FirestoreService().getUser(user.uid);
    if (newUser == null) {
      FirestoreService().createUser(modelUser.User.withName(uid:user.uid,name:user.displayName,surname:'',email:user.email,mobile: user.phoneNumber ?? ''));
    }
    return 'Sign in with google';
  }

  void signOut() {
    _auth.signOut();
  }
}