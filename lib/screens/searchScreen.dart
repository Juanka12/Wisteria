import 'package:flutter/material.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/genresToShow.dart';
import 'package:wisteria/widgets/navigationBar.dart';
import 'package:wisteria/widgets/searchBar.dart';
import 'package:wisteria/widgets/searchResult.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final int pageIndex = 1;
  String toSearch = '';
  Widget pageToDisplay = GenresToShow();
  SearchBar searchBar;


  @override
  void initState() {
    super.initState();
    searchBar = SearchBar(onSubmit: searchQuery,);
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Image(image: AssetImage("assets/images/Descubrir.png"), height: screen.height * 0.18,),
              ),
              Padding(
                padding: EdgeInsets.only(top: 180.0),
                child: this.pageToDisplay,
              ),
              Padding(
                padding: EdgeInsets.only(top: 160.0),
                child: this.searchBar,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchQuery(String query) {
    this.pageToDisplay = SearchResult(query: query,);
    this.searchBar.controller.close();
  }
}