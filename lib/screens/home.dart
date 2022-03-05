import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:musicapp2/colors/app_colors.dart' as AppColors;
import 'package:musicapp2/my_tabs.dart';
import 'package:musicapp2/screens/login.dart';
import 'package:musicapp2/screens/register.dart';
import 'package:musicapp2/screens/search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentindex = 0;
  final tabs = [
    Center(child: Text('kljaf')),
    Center(child: Text('kljaf')),
    Center(child: Text('kljaf')),
    Center(child: Text('kljaf')),
  ];

  late List popularMusic = [];
  late List ListViewMusic = [];

  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/music.json")
        .then((s) {
      setState(() {
        popularMusic = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/ListMusic.json")
        .then((s) {
      setState(() {
        ListViewMusic = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      color: AppColors.background,
      // ignore: prefer_const_constructors
      child: SafeArea(
        // ignore: prefer_const_constructors
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Music App"),
            toolbarHeight: 60.2,
            elevation: 0.2,
            actions: [
              GestureDetector(
                child: Icon(Icons.login),
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
                                itemCount: popularMusic == null
                                    ? 0
                                    : popularMusic.length,
                                itemBuilder: (_, i) {
                                  return Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              popularMusic[i]["image"]),
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
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                ListViewMusic[index]
                                                    ["posters"]),
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
                                              ListViewMusic[index]["raitings"],
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
                                            "Favourites",
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
                          );
                        }),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("content  "),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("content  "),
                      ),
                    ),
                  ]),
                ))
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentindex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Search",
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.verified_user_outlined),
                  label: "Login",
                  backgroundColor: Colors.blue,
                ),
              ],
              onTap: (index) {
                () {
                  setState(() {
                    _currentindex = index;
                  });
                };
              }),
        ),
      ),
    );
  }
}
