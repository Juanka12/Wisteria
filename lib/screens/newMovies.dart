import 'package:flutter/material.dart';
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
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Image(image: AssetImage("assets/images/CircleGold.png"),height: 250.0,),
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
                        child: Image(image: AssetImage("assets/images/Estrenos.png"),height: 200,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 150.0),
                        child: MoviestoShow(),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: Image(image: AssetImage("assets/images/Trailers.png"),height: 200,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 100.0),
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
    return Container(
      padding: EdgeInsets.only(top: 100.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('WISTERIA',style: Theme.of(context).textTheme.headline1,),
              Container(margin: EdgeInsets.only(top: 10.0), color: Colors.black, height: 2.0, width: 200.0,),
            ],
          ),
        ],
      ),
    );
  }
}