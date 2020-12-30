import 'package:flutter/material.dart';
import 'file:///D:/flutterAssignments/ytsAPI/screen/home.dart';
import 'file:///D:/flutterAssignments/ytsAPI/screen/detailedMovieList.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/details": (context) => MovieDetails(),
      },
      debugShowCheckedModeBanner: false,
      title: "YTS API",
      home: Home(),
    );
  }
}
