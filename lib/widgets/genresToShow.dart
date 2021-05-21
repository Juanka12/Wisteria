import 'package:flutter/material.dart';
import 'package:wisteria/bloc/genresListBloc.dart';
import 'package:wisteria/model/genre.dart';
import 'package:wisteria/model/genreResponse.dart';
import 'package:wisteria/widgets/loading.dart';
import 'package:wisteria/widgets/moviesbyGenres.dart';

class GenresToShow extends StatefulWidget {
  @override
  _GenresToShowState createState() => _GenresToShowState();
}

class _GenresToShowState extends State<GenresToShow> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    genresListBloc..getGenres();
  }

  @override
  void dispose() {
    super.dispose();
    this._tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresListBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildGenreList(snapshot.data);
        }
        return Loading();
      },
    );
  }

  Widget buildGenreList(GenreResponse response) {
    List<Genre> genres = response.genres;
    this._tabController = TabController(length: genres.length, vsync: this);
    return Container(
      margin: EdgeInsets.only(top: 80.0),
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              bottom: TabBar(
                controller: this._tabController,
                isScrollable: true,
                tabs: genres.map((Genre genre) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Text(genre.name),
                  );
                }).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: this._tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((genre) {
              return MoviesbyGenres(id: genre.id,);
            }).toList(),
          ),
        ),
      ),
    );
  }
}