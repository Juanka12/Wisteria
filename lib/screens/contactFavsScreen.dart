import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wisteria/bloc/contactFavsBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/loading.dart';

class ContactFavScreen extends StatefulWidget {
  final arguments;

  ContactFavScreen({Key key, @required this.arguments}) : super(key: key);

  @override
  _ContactFavScreenState createState() => _ContactFavScreenState(arguments['id'], arguments['avatar']);
}

class _ContactFavScreenState extends State<ContactFavScreen> {
  final String id;
  final Uint8List avatar;

  _ContactFavScreenState(this.id, this.avatar);

  @override
  void initState() {
    super.initState();
    contactFavsBloc..getFavMovies(this.id);
  }

  @override
  void dispose() {
    super.dispose();
    contactFavsBloc..drain();
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
              Container(
                margin: EdgeInsets.only(top: 10.0, right: 10.0),
                alignment: Alignment.topRight,
                child: Hero(
                  tag: this.id,
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: MemoryImage(this.avatar),
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0, left: 20.0),
                child: Image(image: AssetImage("assets/images/Favoritos.png"),height: screen.height * 0.12,),
              ),
              StreamBuilder<List<Movie>>(
                stream: contactFavsBloc.subject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return buildFavList(snapshot.data, screen);
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

  Widget buildFavList(List<Movie> favs, ScreenSize screen) {
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
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: favs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 40.0,),
            child: GestureDetector(
              onTap: () {
                print(favs[index]);
                NavigationService().navigateTo('movieDetails', arguments: favs[index]);
              },
              child:Row(
                children: <Widget>[
                  Hero(
                    tag: favs[index].id,
                    child: Container(
                      height: screen.height * 0.19,
                      width: screen.width * 0.30,
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
                          image: NetworkImage("https://image.tmdb.org/t/p/w200"+favs[index].poster)
                        )
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    width: screen.width * 0.46,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(favs[index].title, style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.start,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Visitas '+favs[index].popularity.toString(), style: Theme.of(context).textTheme.headline3,),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}