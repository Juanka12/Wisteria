import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/model/user.dart';
import 'package:wisteria/services/firestoreService.dart';
import 'package:wisteria/styles/mainTheme.dart';

class PersonalInfo extends StatefulWidget {
  final User user;
  PersonalInfo({Key key, @required this.user}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState(this.user);
}

class _PersonalInfoState extends State<PersonalInfo> {
  final User user;
  TextEditingController _textController;

  _PersonalInfoState(this.user);

  @override
  void initState() {
    super.initState();
    this._textController = TextEditingController(text: this.user.mobile);
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30.0),
            width: screen.width * 0.56,
            child: Text('Datos Personales', style: Theme.of(context).textTheme.headline4,),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Correo', style: Theme.of(context).textTheme.headline2,),
                Text(this.user.email, style: Theme.of(context).textTheme.headline3,),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Número de móvil', style: Theme.of(context).textTheme.headline2,),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Cambiar teléfono'),
                          content: TextField(
                            controller: this._textController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Teléfono',
                              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6),fontSize: 14),
                            )
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                this._textController.clear();
                                this._textController.text = this.user.mobile;
                              },
                            ),
                            TextButton(
                              child: Text('Cambiar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  this.user.mobile = this._textController.text;    
                                  FirestoreService().setMobileNumber(this._textController.text);                              
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(this.user.mobile == '' ? 'No Existe' : this.user.mobile, style: Theme.of(context).textTheme.headline3,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}