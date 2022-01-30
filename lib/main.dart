import 'package:flutter/material.dart';
import 'package:youxiake_project/routes/route.dart';
import 'package:youxiake_project/transition_page.dart';

import 'config/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '游侠客',
      theme: themeData,
      home: TransitionPage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute:onGenerateRoute
    );
  }
}
