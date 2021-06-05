import 'package:flutter/material.dart';
import 'package:wisteria/bloc/actorDetailBloc.dart';
import 'package:wisteria/model/cast.dart';
import 'package:wisteria/model/castDetail.dart';
import 'package:wisteria/model/screenSize.dart';
import 'package:wisteria/styles/mainTheme.dart';
import 'package:wisteria/widgets/actorsMoviesToShow.dart';
import 'package:wisteria/widgets/loading.dart';

class CastDetailScreen extends StatefulWidget {
  final Cast cast;
  CastDetailScreen({Key key, @required this.cast}) : super(key: key);

  @override
  _CastDetailScreenState createState() => _CastDetailScreenState(this.cast);
}

class _CastDetailScreenState extends State<CastDetailScreen> {
  final Cast cast;
  _CastDetailScreenState(this.cast);

  @override
  void initState() {
    super.initState();
    actorDetailBloc..getCastDetail(this.cast.id);
  }

  @override
  void dispose() {
    super.dispose();
    actorDetailBloc..drain();
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
        child: StreamBuilder<CastDetail>(
          stream: actorDetailBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildDetailPage(snapshot.data, screen);
            }
            return Loading();
          },
        ),
      )
    );
  }

  Widget buildDetailPage(CastDetail cast, ScreenSize screen) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 90.0, top: 40.0, left: 20.0),
          height: screen.height * 0.3,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(3, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(100.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://image.tmdb.org/t/p/original"+cast.profilePath),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.grey.shade300,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(3, 5),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Text(cast.name, style: Theme.of(context).textTheme.headline1,),
              Text(cast.birthPlace, style: Theme.of(context).textTheme.headline3),
              Text(cast.birthday, style: Theme.of(context).textTheme.headline3),
              Text(cast.biography, style: Theme.of(context).textTheme.headline3)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          height: screen.height * 0.3,
          child: ActorsMoviesToShow(id: this.cast.id,),
        ),
      ],
    );
  }
}