import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:musicapp2/components/playlist_screen.dart';
import '../widget/button_widget.dart';
import 'package:musicapp2/widget/button_widget.dart';

import 'edit_profile_page.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('PlayList'),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
      text: 'Create Playlist',
      onClicked: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Myplaylist()),
        );
      });
}
