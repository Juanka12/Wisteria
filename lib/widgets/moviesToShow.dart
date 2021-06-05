import 'package:flutter/material.dart';
import 'package:wisteria/bloc/newMoviesBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/loading.dart';
import 'package:wisteria/widgets/trailersToShow.dart';

class MoviestoShow extends StatefulWidget {
  @override
  _MoviestoShowState createState() => _MoviestoShowState();
}

class _MoviestoShowState extends State<MoviestoShow> {

  @override
  void initState() {
    super.initState();
    moviesBloc..getMovies();
  }

  @override
  void dispose() {
    super.dispose();
    moviesBloc..drain();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return StreamBuilder<MovieResponse>(
      stream: moviesBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildMovieList(snapshot.data, screen);
        }
        return Loading();
      },
    );
  }

  Widget buildMovieList(MovieResponse data, ScreenSize screen) {
    List<Movie> movies = data.movies;
    return Container(
      height: screen.height * 0.27,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0,),
            child: GestureDetector(
              onTap: () {
                NavigationService().navigateTo('movieDetails', arguments: movies[index]);
              },
              child:Hero(
                tag: movies[index].id,
                child: Container(
                  width: screen.width * 0.38,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(3, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://image.tmdb.org/t/p/w200"+movies[index].poster)
                    )
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}