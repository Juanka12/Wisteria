import 'package:flutter/material.dart';
import 'package:wisteria/bloc/genresListBloc.dart';
import 'package:wisteria/model/genre.dart';
import 'package:wisteria/model/genreResponse.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/styles/mainTheme.dart';
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
    ScreenSize screen = MainTheme().getScreenSize(context);
    return StreamBuilder<GenreResponse>(
      stream: genresListBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildGenreList(snapshot.data, screen);
        }
        return Loading();
      },
    );
  }

  Widget buildGenreList(GenreResponse response, ScreenSize screen) {
    List<Genre> genres = response.genres;
    this._tabController = TabController(length: genres.length, vsync: this);
    return Container(
      margin: EdgeInsets.only(top: screen.height * 0.08),
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screen.height * 0.08),
            child: Container(
              height: screen.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TabBar(
                controller: this._tabController,
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black87,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: genres.map((Genre genre) {
                  return Tab(
                    child: Container(
                      width: screen.width * 0.26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(genre.name),
                      ),
                    ),
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