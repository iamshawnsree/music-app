import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:musicapp2/utils/user_preferences.dart';
import 'package:musicapp2/screens/edit_profile_page.dart';
import 'package:musicapp2/model/user.dart';
import 'package:musicapp2/widget/button_widget.dart';
import 'package:musicapp2/widget/profile_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

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
                imagePath: user.imagePath,
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

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
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
            user.country,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
