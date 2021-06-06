import 'package:flutter/material.dart';
import 'package:wisteria/bloc/historialBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/loading.dart';
import 'package:wisteria/widgets/navigationBar.dart';

class HistorialScreen extends StatefulWidget {
  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {

  @override
  void initState() {
    super.initState();
    historialBloc..getHistory();
  }

  @override
  void dispose() {
    super.dispose();
    historialBloc..drain();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(index: 3),
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
                margin: EdgeInsets.only(top: 90.0, left: 20.0),
                child: Image(image: AssetImage("assets/images/Historial.png"),height: screen.height * 0.15,),
              ),
              StreamBuilder<List<Movie>>(
                stream: historialBloc.subject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return buildHistoryList(snapshot.data, screen);
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

  Widget buildHistoryList(List<Movie> movies, ScreenSize screen) {
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
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 40.0,),
            child: GestureDetector(
              onTap: () {
                print(movies[index]);
                NavigationService().navigateTo('movieDetails', arguments: movies[index]);
              },
              child:Row(
                children: <Widget>[
                  Hero(
                    tag: movies[index].id,
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
                          image: NetworkImage("https://image.tmdb.org/t/p/w200"+movies[index].poster)
                        )
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    width: screen.width * 0.36,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(movies[index].title, style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.start,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          alignment: Alignment.centerLeft,
                          child: Text('Visitas '+movies[index].popularity.toString(), style: Theme.of(context).textTheme.headline3,),
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