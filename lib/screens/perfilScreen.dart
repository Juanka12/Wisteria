import 'package:flutter/material.dart';
import 'package:wisteria/bloc/perfilBloc.dart';
import 'package:wisteria/model/user.dart';
import 'package:wisteria/services/authService.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/widgets/loading.dart';
import 'package:wisteria/widgets/mainPerfil.dart';
import 'package:wisteria/widgets/navigationBar.dart';
import 'package:wisteria/widgets/personalInfo.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final int pageIndex = 3;

  @override
  void initState() {
    super.initState();
    perfilBloc..getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    perfilBloc..drain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(index: this.pageIndex),
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<User>(
          stream: perfilBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildPerfilPage(snapshot.data);
            }
            return Loading();
          },
        ),
      ),
    );
  }

  Widget buildPerfilPage(User data) {
    return SafeArea(
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
              ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Sign Out'),
                              content: Text('Estás seguro que desea cerrar sesión ?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Aceptar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    AuthService().signOut();
                                    NavigationService().navigateTo('login');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.0, top: 10.0),
                      alignment: Alignment.topRight,
                      child: Icon(Icons.power_settings_new_outlined, size: 40, color: Colors.amber.shade800,),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.0, right: 80.0),
                    child: Image(
                      image: AssetImage('assets/images/Perfil.png'),
                      height: 140,
                    ),
                  ),
                  MainPerfil(user: data,),
                  PersonalInfo(user: data),
                ],
              ),
            ],
          ),
        );
  }
}