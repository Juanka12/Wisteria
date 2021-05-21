import 'package:flutter/material.dart';
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
        child: Stack(
          children: <Widget>[
            this.pageToDisplay,
            this.searchBar,
          ],
        ),
      ),
    );
  }

  void searchQuery(String query) {
    this.pageToDisplay = SearchResult(query: query,);
    this.searchBar.controller.close();
  }
}