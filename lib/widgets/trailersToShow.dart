import 'package:flutter/material.dart';
import 'package:wisteria/bloc/upcomingTrailersBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/widgets/loading.dart';

class TrailerstoShow extends StatefulWidget {
  @override
  _TrailerstoShowState createState() => _TrailerstoShowState();
}

class _TrailerstoShowState extends State<TrailerstoShow> {
  
  @override
  void initState() {
    super.initState();
    upcomingTrailersBloc..getMovies();
  }

  @override
  void dispose() {
    super.dispose();
    upcomingTrailersBloc..drain();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: upcomingTrailersBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildTrailerList(snapshot.data);
        }
        return Loading();
      },
    );
  }

  Widget buildTrailerList(MovieResponse data){
    List<Movie> movies = data.movies;
    return Container(
      height: 150,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                print('tapped '+movies[index].title);
              },
              child:Stack(
                children: <Widget>[
                  Hero(
                    tag: movies[index].id.toString()+"_trailer",
                    child: Container(
                      width: 240,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(3, 5),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://image.tmdb.org/t/p/original/"+movies[index].backPoster)
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    top: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: Icon(Icons.play_circle_outline, color: Colors.white,size: 50.0,),
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