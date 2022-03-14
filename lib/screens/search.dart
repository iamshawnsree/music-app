import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:musicapp2/model/music_list.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = "";
  List<Musiclist> songs = [];

  @override
  void initState() {
    super.initState();
    readJsonData(searchText);
    print("songs::: $songs");
  }

  Future readJsonData(String searchText) async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/ListMusic.json');
    final list = await json.decode(jsondata);
    if (searchText != "") {
      setState(() {
        songs = [];
      });
    }

    var result = list.map((e) => {
          setState(() {
            songs.add(Musiclist.fromJson(e));
          })
        });
    print("reuslt: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TextField(
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: "Search for song...",
          ),
          onChanged: (text) {
            setState(() {
              searchText = text;
              readJsonData(searchText);
            });
          },
        )),
        body: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image(
                          image: NetworkImage(songs[index].image.toString()),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                songs[index].songname.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(songs[index].artistname.toString()),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            }));
  }
}
