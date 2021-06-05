import 'package:flutter/material.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/model/user.dart';
import 'package:wisteria/services/firestoreService.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/utils/androidStorage.dart';

class MainPerfil extends StatefulWidget {
  final User user;
  MainPerfil({Key key, @required this.user}) : super(key: key);

  @override
  _MainPerfilState createState() => _MainPerfilState(this.user);
}

class _MainPerfilState extends State<MainPerfil> {
  final User user;

  _MainPerfilState(this.user);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Container(
                    margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 50.0, top: 20.0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: screen.height * 0.13,
                              child: FutureBuilder(
                                future: FirestoreService().getAvatar(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return GestureDetector(
                                      onTap: () {
                                        AndroidStorage().pickImage().then((value) {
                                          if (value) {
                                            setState(() {});
                                          }
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage: MemoryImage(snapshot.data),
                                      ),
                                    );
                                  }
                                  return CircleAvatar(
                                    radius: 40.0,
                                    backgroundColor: Colors.grey.shade300,
                                  );
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: screen.width * 0.4,
                              child: Text(this.user.name, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center, maxLines: 2,),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.0, left: 80.0),
                              child: Icon(Icons.person_add_alt, color: Colors.amber.shade800, size: 30.0,),
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigationService().navigateTo('contacts');
                              },
                              child: Text('Contactos', style: Theme.of(context).textTheme.bodyText1,),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.0, left: 80.0),
                              child: Icon(Icons.history_outlined, color: Colors.amber.shade800, size: 30.0,),
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigationService().navigateTo('historial');
                              },
                              child: Text('Historial', style: Theme.of(context).textTheme.bodyText1,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
  }
}