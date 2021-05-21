import 'package:flutter/material.dart';
import 'package:wisteria/bloc/searchBloc.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/model/moviesResponse.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/widgets/loading.dart';

class SearchResult extends StatefulWidget {
  final String query;
  SearchResult({Key key, @required this.query}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState(this.query);
}

class _SearchResultState extends State<SearchResult> {
  final String query;
  _SearchResultState(this.query);

@override
  void initState() {
    super.initState();
    searchBloc..getMovies(this.query);
  }

  @override
  void dispose() {
    super.dispose();
    searchBloc..drain();
  }

  @override
  void didUpdateWidget(SearchResult oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      searchBloc..getMovies(widget.query);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: searchBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildResultList(snapshot.data);
        }
        return Loading();
      },
    );
  }

  Widget buildResultList(MovieResponse response) {
    List<Movie> movies = response.movies;
    print(movies.length);
    return Container(
      margin: EdgeInsets.only(top: 80.0),
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
                          image: movies[index].poster == null ? NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiUqGvs-Wgpbk4a8HcVMjOVeHJ7kiryV12xpX-WwjUty5NwqHlMTm4M1caosM6IYxkW9I&usqp=CAU") : NetworkImage("https://image.tmdb.org/t/p/w200"+movies[index].poster)
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