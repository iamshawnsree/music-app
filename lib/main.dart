import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musicapp2/components/home_screen.dart';
import 'package:musicapp2/detailed_audio_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp2/screens/Home.dart';
import 'package:musicapp2/screens/login.dart';
import 'package:musicapp2/screens/search.dart';
import 'package:musicapp2/themes.dart';
import 'package:musicapp2/utils/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA0XAJHqbcfg0H3un6qUsf8cbMnVULuGyU',
      appId: '1:855528724979:android:d4a96f91fd73e16dc25a86',
      messagingSenderId: '855528724979',
      projectId: 'music-app-24f56',
      authDomain: 'music-app-24f56.firebaseapp.com',
      // databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
      // storageBucket: 'react-native-firebase-testing.appspot.com',
    ),
  );
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;
    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Music Streaming App',
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),

          // ignore: prefer_const_constructors
          home: Login(),
        ),
      ),
    );
  }
}
