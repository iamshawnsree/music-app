import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:musicapp2/screens/edit_profile_page.dart';
import 'package:musicapp2/widget/button_widget.dart';
import 'package:musicapp2/widget/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    setState(() {
      user = auth.currentUser;
    });
  }

  Future getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: FutureBuilder(
              future: getUser(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ProfileWidget(
                        imagePath:
                            'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => EditProfilePage()),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      buildName(user!.email ?? "loading"),
                      const SizedBox(height: 24),
                      Center(child: buildUpgradeButton()),
                      const SizedBox(height: 24),
                      const SizedBox(height: 48),
                      buildAbout(),
                    ],
                  );
                } else {
                  return CircularProgressIndicator(color: Colors.blue);
                }
              }),
        ),
      ),
    );
  }

  /// other way there is no user logged.

  Widget buildName(String email) => Column(
        children: [
          Text(
            email,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Edit',
        onClicked: () {},
      );

  Widget buildAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Country',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              // user.about,
              "Nepal",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
