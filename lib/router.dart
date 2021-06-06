import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisteria/model/cast.dart';
import 'package:wisteria/model/movie.dart';
import 'package:wisteria/screens/castDetailScreen.dart';
import 'package:wisteria/screens/contactFavsScreen.dart';
import 'package:wisteria/screens/contactsScreen.dart';
import 'package:wisteria/screens/favMoviesScreen.dart';
import 'package:wisteria/screens/historialScreen.dart';
import 'package:wisteria/screens/movieDetailScreen.dart';
import 'package:wisteria/screens/newMovies.dart';
import 'package:wisteria/screens/perfilScreen.dart';
import 'package:wisteria/screens/registerAccountScreen.dart';
import 'package:wisteria/screens/searchScreen.dart';
import 'package:wisteria/screens/sessionScreen.dart';

Route<dynamic> generarRuta(RouteSettings ruta) {
  switch (ruta.name) {
    case 'home':
      return MaterialPageRoute(builder: (context) => NewMovies());
    
    case 'movieDetails':
      var movie = ruta.arguments as Movie;
      return MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie));

    case 'fav':
      return MaterialPageRoute(builder: (context) => FavMoviesScreen());

    case 'perfil':
      return MaterialPageRoute(builder: (context) => PerfilScreen());

    case 'login':
      return MaterialPageRoute(builder: (context) => SessionScreen());

    case 'search':
      return MaterialPageRoute(builder: (context) => SearchScreen());

    case 'historial':
    return MaterialPageRoute(builder: (context) => HistorialScreen());

    case 'contacts':
    return MaterialPageRoute(builder: (context) => ContactsScreen());

    case 'contactFavs':
    return MaterialPageRoute(builder: (context) => ContactFavScreen(arguments: ruta.arguments));

    case 'castDetails':
    return MaterialPageRoute(builder: (context) => CastDetailScreen(cast: ruta.arguments as Cast));

    case 'newAccount':
    return MaterialPageRoute(builder: (context) => RegisterAccountScreen());

    default: 
      return MaterialPageRoute(builder: (context) => NewMovies());
  }
}