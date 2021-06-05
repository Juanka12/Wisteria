import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wisteria/bloc/contactsBloc.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/model/user.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/loading.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {

  @override
  void initState() {
    super.initState();
    contactsBloc..getContacts();
  }

  @override
  void dispose() {
    super.dispose();
    contactsBloc..drain();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Scaffold(
      extendBody: true,
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
                    child: Image(image: AssetImage("assets/images/Circle.png"),height: screen.height * 0.31,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Image(image: AssetImage("assets/images/GoldenBG.png")),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0, left: 20.0),
                child: Image(image: AssetImage("assets/images/Contactos.png"),height: screen.height * 0.13,),
              ),
              StreamBuilder<List<User>>(
                stream: contactsBloc.subject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return buildContactList(snapshot.data, screen);
                  }
                  return Loading();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactList(List<User> users, ScreenSize screen) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, top: 220.0),
      height: screen.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Background.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: StreamBuilder<List<Uint8List>>(
        stream: contactsBloc.subjectAvatars.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Contactos'),
                      content: Text('Asegurate de que el numero de teléfono es correcto y la aplicación tiene acceso a tus contactos'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              });
            }
            List<Uint8List> avatars = snapshot.data;
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 40.0,),
                  child: GestureDetector(
                    onTap: () {
                      NavigationService().navigateTo('contactFavs', arguments: {'id': users[index].uid, 'avatar': avatars[index]});
                    },
                    child:Row(
                      children: <Widget>[
                        Hero(
                          tag: users[index].uid,
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(3, 5),
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(avatars[index]),
                              )
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          width: 180,
                          child: Text(users[index].name),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Loading();
        }
      ),
    );
  }
}