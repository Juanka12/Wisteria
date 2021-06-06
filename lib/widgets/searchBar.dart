import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  final Function(String query) onSubmit;
  final FloatingSearchBarController _controller = FloatingSearchBarController();

  FloatingSearchBarController get controller => this._controller;
  
  SearchBar({Key key, @required this.onSubmit}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState(onSubmit, _controller);
}

class _SearchBarState extends State<SearchBar> {
  final Function onSubmit;
  final FloatingSearchBarController _controller;
  _SearchBarState(this.onSubmit, this._controller);
 
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: EdgeInsets.only(top: 16.0, bottom: 56.0),
      transitionDuration: Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: BouncingScrollPhysics(),
      debounceDelay: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      controller: this._controller,
      onQueryChanged: (query) {
        print(query);
      },
      onSubmitted: this.onSubmit,
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
          ),
        );
      },
    );
  }
}