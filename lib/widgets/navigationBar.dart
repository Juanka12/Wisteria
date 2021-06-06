import 'package:flutter/material.dart';
import 'package:wisteria/services/navigationService.dart';

class NavigationBar extends StatefulWidget {
  final int index;
  NavigationBar({Key key, @required this.index}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState(this.index);
}

class _NavigationBarState extends State<NavigationBar> {
  int index;
  _NavigationBarState(this.index);

  List<String> listaNavPag = ['home', 'search', 'fav', 'perfil'];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'fav',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'perfil',
          ),
        ],
        currentIndex: this.index,
        selectedItemColor: Colors.amber.shade900,
        onTap: (int i) {
          if (i != this.index) {
            NavigationService().navigateTo(listaNavPag[i]);
          }
        },
      )
    );
  }
}