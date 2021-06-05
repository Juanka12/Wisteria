import 'package:flutter/material.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/emailCredentials.dart';
import 'package:wisteria/widgets/sessionButtons.dart';

class SessionScreen extends StatefulWidget {
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: screen.width,
        height: screen.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Image(image: AssetImage("assets/images/Circle.png"),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Image(image: AssetImage("assets/images/GoldenBG.png")),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 60.0, right: 120.0),
                    child: Image(
                      image: AssetImage('assets/images/InicioSesion.png'),
                      height: screen.height * 0.22,
                    ),
                  ),
                  EmailCredentials(),
                  SessionButtons(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}