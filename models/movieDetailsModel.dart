import 'package:flutter/cupertino.dart';

class MovieDetailModel {
  int id;
  String title;
  String description;
  List<dynamic> actors;
  double rating;
  int runtime;
  List<dynamic> torrents;

  MovieDetailModel({
    @required this.id,
    @required this.actors,
    @required this.description,
    @required this.rating,
    @required this.runtime,
    @required this.torrents,
    @required this.title,
  });
}
