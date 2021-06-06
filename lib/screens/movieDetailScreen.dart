import 'package:flutter/material.dart';
import 'package:wisteria/bloc/movieDetailBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/movieDetail.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/firestoreService.dart';
import 'package:wisteria/services/movieAPI.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/actorsToShow.dart';
import 'package:wisteria/widgets/loading.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  MovieDetailScreen({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieDetailStateScreen createState() => _MovieDetailStateScreen(this.movie);
}

class _MovieDetailStateScreen extends State<MovieDetailScreen> {
  final Movie movie;
  String trailerKey;
  _MovieDetailStateScreen(this.movie);
  
  @override
  void initState() {
    super.initState();
    FirestoreService().saveHistory(this.movie);
    movieDetailBloc..getMovieDetail(this.movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    movieDetailBloc..drain();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return Scaffold(
      body: Container(
        width: screen.width,
        height: screen.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<MovieDetail>(
          stream: movieDetailBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
                return buildDetailPage(snapshot.data, screen);
            }
            return Loading();
          },
        ),
      ),
    );
  }

  Widget buildDetailPage(MovieDetail detail, ScreenSize screen) {
    String genre = detail.genres;
    if (genre.contains(',')) {
      genre = detail.genres.substring(0, detail.genres.indexOf(','));
    }
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Hero(
                tag: this.movie.id,
                child: Container(
                  height: screen.height * 0.45,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(3, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0)),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: this.movie.poster == null ? NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiUqGvs-Wgpbk4a8HcVMjOVeHJ7kiryV12xpX-WwjUty5NwqHlMTm4M1caosM6IYxkW9I&usqp=CAU") : NetworkImage("https://image.tmdb.org/t/p/original/"+this.movie.poster)
                    )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.0,top: screen.height * 0.36),
              child: Container(
                height: screen.height * 0.09,
                width: screen.width * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/GoldTexture.png"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screen.width * 0.12,top: screen.height * 0.372),
              child: IconButton(
                icon: detail.fav == true ? Icon(Icons.favorite, color: Colors.white, size: 40.0,) : Icon(Icons.favorite_border_outlined, color: Colors.white, size: 40.0,),
                onPressed: () {
                  setState(() {
                      if (detail.fav == false) {
                        FirestoreService().saveFav(this.movie);
                        detail.fav = true;
                      }else{
                        FirestoreService().deleteFav(this.movie);
                        detail.fav = false;
                      }
                    });
                  },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0, right: screen.width * 0.85, top: screen.height * 0.07),
              child: Container(
                padding: EdgeInsets.only(left: 4.0),
                height: screen.height * 0.05,
                width: screen.width * 0.1,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(3, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Colors.grey.shade300,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.amber.shade800,),
                  onPressed: () {
                    NavigationService().back();
                  },
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: screen.width * 0.46,
                child: Text(this.movie.title, style: Theme.of(context).textTheme.headline2),
              ),
              Container(
                height: 20,
                width: 1.2,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(detail.releaseDate, style: Theme.of(context).textTheme.headline3),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50.0, right: 40.0, top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(genre, style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                child: Text(detail.duration, style: Theme.of(context).textTheme.headline3),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50.0, right: 40.0, top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Image(image: AssetImage("assets/icons/metacritic.png")),
                      height: screen.height * 0.05,
                    ),
                    Text(detail.metacriticRate)
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Image(image: AssetImage("assets/icons/imdb.png")),
                      width: screen.width * 0.18,
                    ),
                    Text(movie.rating.toString())
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30.0, left: 50.0),
          child: Text("Sinopsis", style: Theme.of(context).textTheme.headline2),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, right: 40.0, left: 50.0),
          child: Text(this.movie.overview, style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.justify,),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 50.0),
          child: Text("Dirigida por", style: Theme.of(context).textTheme.headline2),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 50.0),
          child: Text(detail.director, style: Theme.of(context).textTheme.headline3),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 50.0),
          child: Text("Guión por", style: Theme.of(context).textTheme.headline2),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 50.0, right: 40.0),
          child: Text(detail.writer, style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.justify),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 50.0),
          child: Text("Reparto", style: Theme.of(context).textTheme.headline2),
        ),
        Container(
          height: 180,
          width: 300,
          margin: EdgeInsets.only(top: 10.0),
          child: ActorsToShow(movie: this.movie.id),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 50.0),
          child: Text("Tráiler", style: Theme.of(context).textTheme.headline2),
        ),
        this.trailerKey == null ? trailerThumbnail(screen) : trailerVideo(screen),
      ],
    );
  }

  Widget trailerThumbnail(ScreenSize screen) {
    return GestureDetector(
          onTap: () {
            MovieAPI().getTrailer(this.movie.id).then((value) {
              setState(() {
                this.trailerKey = value;
              });
            });
          },
          child: Container(
            height: screen.height * 0.31,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 50.0, right: 40.0),
                  height: screen.height * 0.23,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(3, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://image.tmdb.org/t/p/original/"+this.movie.backPoster)
                      )
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  top: 0.0,
                  right: 0.0,
                  left: 18.0,
                  child: Icon(Icons.play_circle_outline, color: Colors.white,size: 50.0,),
                ),
              ],
            ),
          ),
        );
  }

  Widget trailerVideo(ScreenSize screen) {
    return GestureDetector(
          onTap: () {
            MovieAPI().getTrailer(this.movie.id).then((value) {
              setState(() {
                this.trailerKey = null;
              });
            });
          },
          child: Container(
            height: screen.height * 0.31,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 50.0, right: 40.0),
                  height: screen.height * 0.23,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(3, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      shape: BoxShape.rectangle,
                    ),
                    child: YoutubePlayer(
                      onEnded: (metaData) {
                        setState(() {
                          this.trailerKey = null;                    
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
              ],
            ),
          ),
        );
  }
}