import 'package:flutter/material.dart';
import 'package:wisteria/bloc/upcomingTrailersBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/movieAPI.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/loading.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerstoShow extends StatefulWidget {
  @override
  _TrailerstoShowState createState() => _TrailerstoShowState();

}

class _TrailerstoShowState extends State<TrailerstoShow> {
  String trailerKey;
  int containerId;
  
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
    ScreenSize screen = MainTheme().getScreenSize(context);
    return StreamBuilder<MovieResponse>(
      stream: upcomingTrailersBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildTrailerList(snapshot.data, screen);
        }
        return Loading();
      },
    );
  }

  Widget buildTrailerList(MovieResponse data, ScreenSize screen){
    List<Movie> movies = data.movies;
    return Container(
      height: screen.height * 0.19,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          if (this.containerId != index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                MovieAPI().getTrailer(movies[index].id).then((value) {
                  setState(() {
                    this.containerId = index;
                    this.trailerKey = value;
                  });
                });              
              },
              child:Stack(
                children: <Widget>[
                  Container(
                    width: screen.width * 0.61,
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
          }
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  this.containerId = null;
                });
              },
              child: Container(
                width: screen.width * 0.61,
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
                ),
                child: YoutubePlayer(
                  onEnded: (metaData) {
                    setState(() {
                      this.containerId = null;                    
                    });                  
                  },
                  controller: YoutubePlayerController(
                    initialVideoId: this.trailerKey,
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      hideControls: true,
                    ),
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