import 'package:flutter/material.dart';
import 'package:wisteria/bloc/moviesbyGenreBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/loading.dart';

class MoviesbyGenres extends StatefulWidget {
  final int id;
  MoviesbyGenres({Key key, @required this.id}) : super(key: key);

  @override
  _MoviesbyGenresState createState() => _MoviesbyGenresState(this.id);
}

class _MoviesbyGenresState extends State<MoviesbyGenres> {
  final int id;
  _MoviesbyGenresState(this.id);

  @override
  void initState() {
    super.initState();
    moviesbyGenreBloc..getMoviesbyGenre(this.id);
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: StreamBuilder<MovieResponse>(
        stream: moviesbyGenreBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error.length <= 0) {
              return buildGenreMovies(snapshot.data, screen);
            }
          }
          return Loading();
        },
      ),
    );
  }

  Widget buildGenreMovies(MovieResponse response, ScreenSize screen) {
    List<Movie> movies = response.movies;
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 50.0,),
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
                      height: screen.height * 0.25,
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
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    width: screen.width * 0.46,
                    child: Text(movies[index].title, style: Theme.of(context).textTheme.headline2, textAlign: TextAlign.center,),
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