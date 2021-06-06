import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wisteria/screens/wrapper.dart';
import 'package:wisteria/widgets/loading.dart';

void main() {
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  //   statusBarBrightness: Brightness.light,
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Wrapper();
        }
        return Loading();
      },
    );
  }
}
