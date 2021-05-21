import 'package:flutter/material.dart';
import 'package:wisteria/bloc/moviesbyGenreBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/services/navigationService.dart';
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
              return buildGenreMovies(snapshot.data);
            }
          }
          return Loading();
        },
      ),
    );
  }

  Widget buildGenreMovies(MovieResponse response) {
    List<Movie> movies = response.movies;
    return Container(
      height: 220,
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
                      height: 200,
                      width: 150,
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
                    width: 180,
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