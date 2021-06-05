import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisteria/router.dart';
import 'package:wisteria/screens/SessionScreen.dart';
import 'package:wisteria/screens/newMovies.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    User user = FirebaseAuth.instance.currentUser;
    Widget screentoShow;
    if (user != null) {
      screentoShow = NewMovies();
    }else {
      screentoShow = SessionScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService().navigationKey,
      onGenerateRoute: generarRuta,
      title: 'Wisteria App',
      theme: MainTheme().theme,
      home: screentoShow,
    );
  }
}