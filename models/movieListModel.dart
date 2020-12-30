import 'package:flutter/cupertino.dart';

class MovieListModel {
  int id;
  String title;
  String moviePosterURL;
  String madeYear;

  MovieListModel({
    @required this.id,
    @required this.title,
    @required this.moviePosterURL,
    @required this.madeYear,
  });
}
