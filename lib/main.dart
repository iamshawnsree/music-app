import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musicapp2/detailed_audio_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp2/screens/Home.dart';

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
    return MaterialApp(
      title: 'Music Streaming App',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: prefer_const_constructors
      home: MyHomePage(),
    );
  }
}
