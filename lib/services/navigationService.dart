import 'package:flutter/cupertino.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  static final NavigationService _instance = NavigationService._internalConstructor();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internalConstructor();

  void back() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushNamed(routeName, arguments: arguments);
  }
}