import 'package:flutter/material.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/authService.dart';
import 'package:wisteria/styles/mainTheme.dart';

class RegisterAccountScreen extends StatefulWidget {
  @override
  _RegisterAccountScreenState createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

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
                        height: screen.height * 0.23,
                        width: screen.width * 0.82,
                        padding: EdgeInsets.only(top: 60.0),
                        child: Image(
                          image: AssetImage('assets/images/NuevaCuenta.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 50.0, top: 40.0),
                        height: screen.height * 0.31,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.grey.shade300,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(3, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 40.0),
                              alignment: Alignment.centerLeft,
                              child: Text('Correo',style: Theme.of(context).textTheme.headline2,),
                            ),
                            Container(
                              width: screen.width * 0.64,
                              height: screen.height * 0.05,
                              child: TextField(
                                controller: this._emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6),fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 40.0),
                              alignment: Alignment.centerLeft,
                              child: Text('Contraseña',style: Theme.of(context).textTheme.headline2,),
                            ),
                            Container(
                              width: screen.width * 0.64,
                              height: screen.height * 0.05,
                              child: TextField(
                                controller: this._passwordController,
                                obscureText: true,
                                autocorrect: false,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                  hintText: 'Contraseña',
                                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6),fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        height: screen.height * 0.1,
                        width: screen.width * 0.51,
                        child: ElevatedButton(
                          child: Text('Crear Cuenta'),
                          onPressed: () {
                            if (this._emailController.text.isNotEmpty && this._passwordController.text.isNotEmpty) {
                              AuthService().registerEmailPassword(this._emailController.text, this._passwordController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}