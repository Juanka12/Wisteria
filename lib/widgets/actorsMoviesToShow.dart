import 'package:flutter/material.dart';
import 'package:wisteria/bloc/actorMoviesBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/loading.dart';

class ActorsMoviesToShow extends StatefulWidget {
  final int id;
  ActorsMoviesToShow({Key key, @required this.id}) : super(key: key);

  @override
  _ActorsMoviesToShowState createState() => _ActorsMoviesToShowState(this.id);
}

class _ActorsMoviesToShowState extends State<ActorsMoviesToShow> {
  final int id;
  _ActorsMoviesToShowState(this.id);

  @override
  void initState() {
    super.initState();
    actorMoviesBloc..getCastMovies(id);
  }

  @override
  void dispose() {
    super.dispose();
    actorMoviesBloc..drain();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return StreamBuilder<List<Movie>>(
      stream: actorMoviesBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildMovieList(snapshot.data, screen);
        }
        return Loading();
      },
    );
  }

  Widget buildMovieList(List<Movie> movies, ScreenSize screen) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 30.0),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0,),
          child: GestureDetector(
            onTap: () {
              NavigationService().navigateTo('movieDetails', arguments: movies[index]);
            },
            child: Column(
              children: <Widget>[
                Hero(
                  tag: movies[index].id,
                  child: Container(
                    height: screen.height * 0.14,
                    width: screen.width * 0.23,
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
                        image: movies[index].poster == null ? NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiUqGvs-Wgpbk4a8HcVMjOVeHJ7kiryV12xpX-WwjUty5NwqHlMTm4M1caosM6IYxkW9I&usqp=CAU") : NetworkImage("https://image.tmdb.org/t/p/w200"+movies[index].poster)
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: screen.width * 0.21,
                  child: Text(movies[index].title, textAlign: TextAlign.start,),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}