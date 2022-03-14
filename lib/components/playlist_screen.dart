import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:musicapp2/model/music_list.dart';

class Myplaylist extends StatefulWidget {
  Myplaylist({Key? key}) : super(key: key);
  @override
  State<Myplaylist> createState() => _MyplaylistState();
}

class _MyplaylistState extends State<Myplaylist> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Playlists"),
        ),
        body: FutureBuilder(
          future: ReadJsonData(searchText),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<Musiclist>;
              return ListView.builder(
                  itemCount: items == null ? 0 : items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                                image:
                                    NetworkImage(items[index].image.toString()),
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
                                      items[index].songname.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                        items[index].artistname.toString()),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  // ignore: non_constant_identifier_names
  Future<List<Musiclist>> ReadJsonData(String searchText) async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/ListMusic.json');
    final list = json.decode(jsondata) as List<dynamic>;
    // return list.where((element) => Musiclist.fromJson(e).c)
    return list.map((e) => Musiclist.fromJson(e)).toList();
  }
}
