import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:musicapp2/detailed_audio_page.dart';
import 'package:musicapp2/my_tabs.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:musicapp2/colors/app_colors.dart' as AppColors;
import 'package:musicapp2/screens/login.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:musicapp2/detailed_audio_page.dart';
import 'package:musicapp2/audiofile.dart';
import 'package:musicapp2/screens/login.dart';
import 'package:musicapp2/screens/playlist.dart';

import '../screens/search.dart';

import '../screens/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Icon customIcon = const Icon(Icons.search);

  late List pMusic = [];
  late List popularMusic = [];
  late List ListViewMusic = [];
  late List trendingMusic = [];

  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("assets/music.json")
        .then((s) {
      setState(() {
        pMusic = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("assets/popularmusic.json")
        .then((s) {
      setState(() {
        popularMusic = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("assets/trendingmusic.json")
        .then((s) {
      setState(() {
        trendingMusic = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("assets/ListMusic.json")
        .then((s) {
      setState(() {
        ListViewMusic = json.decode(s);
      });
    });
  }

  setupAlan() {
    AlanVoice.addButton(
      "2a7d3516fa0a7bb8a07dab96e0745e9d2e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT,
    );
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "Search":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
        break;
      case "back":
        Navigator.pop(context);
        break;
      case "Play":
        break;
      case "Pause":
        AudioPlayer().stop();
        break;
      case "Privious":
        break;
      case "Next":
        break;
      case "Home":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case "Login":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
        break;
      case "Playlist":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Playlist()));
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    setupAlan();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.background,
        // ignore: prefer_const_constructors
        child: SafeArea(
            // ignore: prefer_const_constructors
            child: Scaffold(
          appBar: AppBar(
            title: const Text("Music Streaming"),
            toolbarHeight: 60.2,
            elevation: 0.2,
            actions: [
              GestureDetector(
                child: Icon(Icons.account_box_rounded),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Login();
                    }),
                  )
                },
              ),
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Text("Popular Songs",
                              style: TextStyle(fontSize: 30)),
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                Container(
                  height: 180,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          left: -45,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 180,
                            child: PageView.builder(
                                controller:
                                    PageController(viewportFraction: 0.8),
                                itemCount: pMusic == null ? 0 : pMusic.length,
                                itemBuilder: (_, i) {
                                  return Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(pMusic[i]["image"]),
                                          fit: BoxFit.fill,
                                        )),
                                  );
                                }),
                          ))
                    ],
                  ),
                ),
                Expanded(
                    child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                              indicatorPadding:
                                  const EdgeInsets.only(bottom: 20),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 7,
                                      offset: Offset(0, 0),
                                    )
                                  ]),
                              tabs: [
                                AppTabs(
                                    color: AppColors.menu1Color, text: "New"),
                                AppTabs(
                                    color: AppColors.menu2Color,
                                    text: "Popular"),
                                AppTabs(
                                    color: AppColors.menu3Color,
                                    text: "Trending"),
                              ],
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(controller: _tabController, children: [
                    ListView.builder(
                        itemCount:
                            ListViewMusic == null ? 0 : ListViewMusic.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVarViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),
                                    )
                                  ]),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailedAudioPage(
                                                musicData: ListViewMusic,
                                                index: index,
                                              )));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                ListViewMusic[index]["image"],
                                              ),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star_border_purple500,
                                                  size: 20,
                                                  color: AppColors.starColor),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                ListViewMusic[index]
                                                    ["raitings"],
                                                style: TextStyle(
                                                  color: AppColors.menu2Color,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            ListViewMusic[index]["songname"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ListViewMusic[index]["artistname"],
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.normal,
                                              color: AppColors.subTitleText,
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: AppColors.loveColor,
                                            ),
                                            child: Text(
                                              "New",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    Material(
                      child: ListView.builder(
                          itemCount:
                              popularMusic == null ? 0 : popularMusic.length,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.tabVarViewColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2),
                                      )
                                    ]),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailedAudioPage(
                                                  musicData: popularMusic,
                                                  index: index,
                                                )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  popularMusic[index]["image"],
                                                ),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                    Icons.star_border_purple500,
                                                    size: 20,
                                                    color: AppColors.starColor),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  popularMusic[index]
                                                      ["raitings"],
                                                  style: TextStyle(
                                                    color: AppColors.menu2Color,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              popularMusic[index]["songname"],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              popularMusic[index]["artistname"],
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.subTitleText,
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: AppColors.loveColor,
                                              ),
                                              child: Text(
                                                "Popular",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Avenir",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Material(
                      child: ListView.builder(
                          itemCount:
                              trendingMusic == null ? 0 : trendingMusic.length,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.tabVarViewColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2),
                                      )
                                    ]),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailedAudioPage(
                                                  musicData: trendingMusic,
                                                  index: index,
                                                )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  trendingMusic[index]["image"],
                                                ),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                    Icons.star_border_purple500,
                                                    size: 20,
                                                    color: AppColors.starColor),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  trendingMusic[index]
                                                      ["raitings"],
                                                  style: TextStyle(
                                                    color: AppColors.menu2Color,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              trendingMusic[index]["songname"],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              trendingMusic[index]
                                                  ["artistname"],
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: "Avenir",
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.subTitleText,
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: AppColors.loveColor,
                                              ),
                                              child: Text(
                                                "Trending",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Avenir",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ]),
                ))
              ],
            ),
          ),
        )));
  }
}
