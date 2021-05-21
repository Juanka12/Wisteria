import 'package:flutter/material.dart';

class EmailCredentials extends StatefulWidget {
  @override
  _EmailCredentialsState createState() => _EmailCredentialsState();
}

class _EmailCredentialsState extends State<EmailCredentials> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 50.0),
      height: 250,
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
                width: 250,
                height: 40,
                child: TextField(
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
                width: 250,
                height: 40,
                child: TextField(
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
              Container(
                width: 150,
                child: Text('¿Has olvidado la contraseña?', style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.center,),
              ),
            ],
      ),
    );
  }
}