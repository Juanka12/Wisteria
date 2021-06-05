import 'package:flutter/material.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/moviesToShow.dart';
import 'package:wisteria/widgets/navigationBar.dart';
import 'package:wisteria/widgets/trailersToShow.dart';

class NewMovies extends StatefulWidget {
  @override
  _NewMoviesState createState() => _NewMoviesState();
}

class _NewMoviesState extends State<NewMovies> {
  final int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(index: this.pageIndex),
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
                    child: Image(image: AssetImage("assets/images/CircleGold.png"),height: screen.height * 0.31,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Image(image: AssetImage("assets/images/BG.png")),
                  ),
                ],
              ),
              ListView(
                children: <Widget>[
                  Title(),
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Image(image: AssetImage("assets/images/Estrenos.png"),height: screen.height * 0.25,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screen.height * 0.185),
                        child: MoviestoShow(),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: Image(image: AssetImage("assets/images/Trailers.png"),height: screen.height * 0.25,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screen.height * 0.125),
                        child: TrailerstoShow(),
                      ),
                    ],
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

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Container(
      padding: EdgeInsets.only(top: screen.height * 0.125),
      width: screen.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('WISTERIA',style: Theme.of(context).textTheme.headline1,),
              Container(margin: EdgeInsets.only(top: 10.0), color: Colors.black, height: 2.0, width: screen.width * 0.51,),
            ],
          ),
        ],
      ),
    );
  }
}