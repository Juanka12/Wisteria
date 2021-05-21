import 'package:flutter/material.dart';
import 'package:wisteria/bloc/newMoviesBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/widgets/loading.dart';

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
    return StreamBuilder<MovieResponse>(
      stream: moviesBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildMovieList(snapshot.data);
        }
        return Loading();
      },
    );
  }

  Widget buildMovieList(MovieResponse data) {
    List<Movie> movies = data.movies;
    return Container(
      height: 220,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0,),
            child: GestureDetector(
              onTap: () {
                print(movies[index]);
                NavigationService().navigateTo('movieDetails', arguments: movies[index]);
              },
              child:Hero(
                tag: movies[index].id,
                child: Container(
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
            ),
          );
        },
      ),
    );
  }
}