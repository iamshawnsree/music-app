import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:musicapp2/model/user.dart';
import 'package:musicapp2/screens/profile.dart';
import 'package:musicapp2/utils/user_preferences.dart';
import 'package:musicapp2/widget/profile_widget.dart';
import 'package:musicapp2/widget/textfield_widget.dart';
import 'package:musicapp2/widget/button_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Edit profile'),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Country',
                  text: user.country,
                  maxLines: 1,
                  onChanged: (country) {},
                ),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton()),
              ],
            ),
          ),
        ),
      );
  Widget buildUpgradeButton() => ButtonWidget(
        text: 'UPDATE',
        onClicked: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Profile()),
          );
        },
      );
}
