import 'package:flutter/material.dart';
import 'package:wisteria/bloc/actorsBloc.dart';
import 'package:wisteria/model/cast.dart';
import 'package:wisteria/model/castResponse.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/services/navigationService.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/loading.dart';

class ActorsToShow extends StatefulWidget {
  final int movie;
  ActorsToShow({Key key, @required this.movie}) : super(key: key);

  @override
  _ActorsToShowState createState() => _ActorsToShowState(this.movie);
}

class _ActorsToShowState extends State<ActorsToShow> {
  final int movie;
  _ActorsToShowState(this.movie);

  @override
  void initState() {
    super.initState();
    actorsBloc..getCast(this.movie);
  }

  @override
  void dispose() {
    super.dispose();
    actorsBloc..drain();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize screen = MainTheme().getScreenSize(context);
    return StreamBuilder<CastResponse>(
      stream: actorsBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildCastList(snapshot.data, screen);
        }
        return Loading();
      },
    );
  }

  Widget buildCastList(CastResponse data, ScreenSize screen) {
    List<Cast> cast = data.casts;
    return ListView.builder(
      padding: EdgeInsets.only(left: 30.0),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: cast.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0,),
          child: GestureDetector(
            onTap: () {
              print(cast[index].id);
              NavigationService().navigateTo('castDetails', arguments: cast[index]);
            },
            child: Column(
              children: <Widget>[
                Hero(
                  tag: cast[index].id,
                  child: Container(
                    height: screen.height * 0.13,
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
                        image: cast[index].img == null ? NetworkImage("https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png") : NetworkImage("https://image.tmdb.org/t/p/w200"+cast[index].img)
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  width: screen.width * 0.21,
                  child: Text(cast[index].name, textAlign: TextAlign.start,),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}