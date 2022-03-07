import 'package:flutter/material.dart';
import 'package:musicapp2/colors/app_colors.dart' as AppColors;
import 'package:musicapp2/components/home_screen.dart';
import 'package:musicapp2/screens/playlist.dart';
import 'package:musicapp2/screens/profile.dart';
import 'package:musicapp2/screens/search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentindex = 0;

  List<dynamic> tabs = [
    const HomeScreen(),
    const Search(),
    Profile(),
    const Playlist()
  ];

  void onNavigationSelect(int index) {
    setState(() {
      _currentindex = index;
    });
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
          body: tabs[_currentindex],
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
                  label: "Playlist",
                  backgroundColor: Colors.blue,
                ),
              ],
              onTap: (index) {
                onNavigationSelect(index);
              }),
        ),
      ),
    );
  }
}
