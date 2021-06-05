import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/authService.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';

class SessionButtons extends StatefulWidget {
  @override
  _SessionButtonsState createState() => _SessionButtonsState();
}

class _SessionButtonsState extends State<SessionButtons> {
  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 50.0),
          height: screen.height * 0.05,
          width: screen.width * 0.76,
          child: ElevatedButton(
            onPressed: () async {
              await AuthService().signInGoogle();
              NavigationService().navigateTo('home');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: Icon(BrandIcons.google, color: Colors.black,),
                ),
                Text('Inicia sesión con Google', style: TextStyle(color: Colors.black),)
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 50.0),
          height: screen.height * 0.05,
          width: screen.width * 0.76,
          child: ElevatedButton(
            onPressed: () {
              NavigationService().navigateTo('newAccount');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text('Crear cuenta nueva', style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
      ],
    );
  }
}