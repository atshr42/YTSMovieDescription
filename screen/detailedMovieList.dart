import 'package:flutter/material.dart';
import 'file:///D:/flutterAssignments/ytsAPI/models/movieListModel.dart';
import 'file:///D:/flutterAssignments/ytsAPI/models/movieDetailsModel.dart';
import 'dart:convert';
import 'file:///D:/flutterAssignments/ytsAPI/models/torrentModel.dart';
import 'file:///D:/flutterAssignments/ytsAPI/models/actorList.dart';

import 'package:http/http.dart';

class MovieDetails extends StatefulWidget {
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  double height;
  double width;
  List<Widget> _listItems = List();
  List<Widget> _listOfTorrents = List();
  List<Widget> _listOfActors = List();

  @override
  Widget build(BuildContext context) {
    MovieListModel model = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
        actions: [
          _iconGenerator(model),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _myList(),
      ),
    );
  }

  Widget _myList() {
    return SizedBox(
      height: height * .80,
      width: width,
      child: ListView(
        children: _listItems,
      ),
    );
  }

  Widget _iconGenerator(MovieListModel model) {
    return IconButton(
      icon: Icon(Icons.get_app_outlined),
      onPressed: () {
        _fetch(model);
      },
    );
  }

  _fetch(MovieListModel model) async {
    String detailUrl = "https://yts.mx/api/v2/movie_details.json?movie_id=" +
        model.id.toString() +
        "&with_images=true&with_cast=true";
    Response response = await get(detailUrl);
    Map<String, dynamic> list = jsonDecode(response.body);
    Map<String, dynamic> data = list["data"];
    Map<String, dynamic> movie = data["movie"];
    List<Widget> tempList = List();

    Map eachElement = movie;
    MovieDetailModel detailModel = MovieDetailModel(
      id: eachElement["id"],
      actors: eachElement["cast"],
      description: eachElement["description_full"],
      rating: eachElement["rating"],
      runtime: eachElement["runtime"],
      torrents: eachElement["torrents"],
      title: eachElement["title"],
    );
    List<Widget> tempListTorrent = List();
    for (int i = 0; i < detailModel.torrents.length; i++) {
      Map eachElement = detailModel.torrents[i];
      TorrentList list = TorrentList(
        quality: eachElement["quality"],
        size: eachElement["size"],
      );
      Widget torrentCard = _torrentCard(list);
      tempList.add(torrentCard);
    }

    // List<Widget> tempListActors = List();
    // for (int i = 0; i < detailModel.actors.length; i++) {
    //   Map eachElement = detailModel.actors[i];
    //   ActorList actorList = ActorList(
    //     name: eachElement["name"],
    //     characterName: eachElement["character_name"],
    //   );
    //   Widget actorCard = _actorCard(actorList);
    //   tempListActors.add(actorCard);
    // }

    // _listOfActors = tempListActors;
    _listOfTorrents = tempListTorrent;
    Widget titleCard = _card(detailModel);
    tempList.add(titleCard);
    _listItems = tempList;
    setState(() {});
  }

  Widget _torrentCard(TorrentList list) {
    return Column(
      children: [
        Text("Available Format :"),
        Row(
          children: [
            Text("Quality : "),
            Text(list.quality),
          ],
        ),
        Row(
          children: [
            Text("Size: "),
            Text(list.size),
          ],
        ),
      ],
    );
  }

  // Widget _actorCard(ActorList actorList) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Text("Name : "),
  //           Text(actorList.name),
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           Text("Character name : "),
  //           Text(actorList.characterName),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _card(MovieDetailModel model) {
    return Card(
      child: Column(
        children: [
          Text("Description"),
          Text(model.description),
          Row(
            children: [
              Text("Ratings : "),
              Text(model.rating.toString()),
            ],
          ),
          Row(
            children: [
              Text("Runtime : "),
              Text(
                model.runtime.toString(),
              ),
              Text(" minutes"),
            ],
          ),
          Column(
            children: _listOfTorrents,
          ),
          // Text("Actors"),
          // Column(
          //   children: _listOfActors,
          // )
        ],
      ),
    );
  }
}
