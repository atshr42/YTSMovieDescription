import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'file:///D:/flutterAssignments/ytsAPI/models/movieListModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 1;
  String _url;
  double height;
  double width;
  List<Widget> _listItems = List();
  @override
  Widget build(BuildContext context) {
    _url = "https://yts.mx/api/v2/list_movies.json?page=" + counter.toString();
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("YTS API"),
        actions: [
          _iconGenerator(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            _myList(),
            RaisedButton(
              onPressed: () {
                counter++;
                _url = "https://yts.mx/api/v2/list_movies.json?page=" +
                    counter.toString();
                _fetch(_url);
                setState(() {});
              },
              child: Text("Next Page"),
            )
          ],
        ),
      ),
    );
  }

  Widget _myList() {
    return SizedBox(
      height: height * .75,
      width: width,
      child: ListView(
        children: _listItems,
      ),
    );
  }

  Widget _card(MovieListModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: model);
      },
      child: Card(
        color: Colors.grey,
        child: Column(
          children: [
            Text(model.title),
            Image.network(
              model.moviePosterURL,
              width: width * 0.5,
            ),
            Row(
              children: [
                Text("Made year : "),
                Text(model.madeYear),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconGenerator() {
    return IconButton(
      icon: Icon(Icons.refresh_rounded),
      onPressed: () {
        _url = _url = "https://yts.mx/api/v2/list_movies.json?page=1";
        _fetch(_url);
      },
    );
  }

  _fetch(String _url) async {
    String url = _url;
    Response response = await get(url);
    Map<String, dynamic> list = jsonDecode(response.body);
    Map<String, dynamic> data = list["data"];
    List<dynamic> movies = data["movies"];
    List<Widget> tempList = List();
    for (int i = 0; i < movies.length; i++) {
      Map eachElement = movies[i];
      MovieListModel model = MovieListModel(
        id: eachElement["id"],
        title: eachElement["title"],
        moviePosterURL: eachElement["large_cover_image"],
        madeYear: eachElement["year"].toString(),
      );
      // print(model.id);
      // String title = eachElement["title"];
      // String imageURL = eachElement["large_cover_image"];
      // String madeYear = eachElement["year"].toString();
      Widget titleCard = _card(model);
      tempList.add(titleCard);
    }
    _listItems = tempList;
    setState(() {});
  }
}
