import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:musicapp2/screens/edit_profile_page.dart';
import 'package:musicapp2/screens/home.dart';
import 'package:musicapp2/widget/button_widget.dart';
import 'package:musicapp2/widget/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    detectUser();
  }

  final FirebaseAuth _auth1 = FirebaseAuth.instance;
  void detectUser() async {
    if (_auth1.currentUser == null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
    }
    //   //else {
    //   //   Navigator.push(context, MaterialPageRoute(builder: (_) => const Profile()));
    //   // }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth1.currentUser!;
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath:
                    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 24),
              // Center(child: buildUpgradeButton()),
              // const SizedBox(height: 24),
              const SizedBox(height: 48),
              buildCountry(user),
            ],
          ),
        ),
      ),
    );
  }

  /// other way there is no user logged.

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.email.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email.toString(),
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  // Widget buildUpgradeButton() => ButtonWidget(
  //       text: 'UPDATE',
  //       onClicked: () {},
  //     );

  Widget buildCountry(User user) => Column(
        children: [
          Text("Country"),
          const SizedBox(height: 6),
          Text(
            'nepal',
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
