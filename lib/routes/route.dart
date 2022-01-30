import 'package:flutter/material.dart';
import 'package:youxiake_project/views/openApp.dart';
import 'package:youxiake_project/views/tabs/Home/home.dart';

final route = {
  '/': (context) => HomePage(),
  '/openPage': (context) => OpenAppPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = route[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
