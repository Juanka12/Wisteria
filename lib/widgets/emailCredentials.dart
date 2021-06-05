import 'package:flutter/material.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/authService.dart';
import 'package:wisteria/styles/mainTheme.dart';

class EmailCredentials extends StatefulWidget {
  @override
  _EmailCredentialsState createState() => _EmailCredentialsState();
}

class _EmailCredentialsState extends State<EmailCredentials> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  
  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 50.0),
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
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    width: screen.width * 0.20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black38,
                      ),
                      child: Text('Entrar'),
                      onPressed: () {
                        AuthService().signInWithEmailPassword(this._emailController.text, this._passwordController.text);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40.0),
                    width: screen.width * 0.38,
                    child: Text('¿Has olvidado la contraseña?', style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ],
      ),
    );
  }
}