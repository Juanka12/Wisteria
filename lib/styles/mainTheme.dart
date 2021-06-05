import 'package:flutter/material.dart';
import 'package:wisteria/model/screenSize.dart';

class MainTheme {

  ScreenSize getScreenSize(BuildContext context) {
    ScreenSize screen = ScreenSize(height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width);
    return screen;
  }

  ThemeData get theme => ThemeData(
    textTheme: TextTheme(
      headline1: TextStyle(fontFamily: 'Classico', color: Colors.black, fontSize: 50.0, fontWeight: FontWeight.bold),
      headline2: TextStyle(fontFamily: 'Classico', color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
      headline3: TextStyle(fontFamily: 'Classico', color: Colors.black54, fontSize: 20.0, fontWeight: FontWeight.bold),
      headline4: TextStyle(fontFamily: 'Classico', color: Colors.amber.shade900, fontSize: 40.0, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontFamily: 'Classico', color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
    )
  );
}