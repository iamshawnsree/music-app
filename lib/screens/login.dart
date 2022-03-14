import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapp2/components/home_screen.dart';
import 'package:musicapp2/screens/forgot_password.dart';
import 'package:musicapp2/screens/home.dart';
import 'package:musicapp2/screens/profile.dart';
import 'package:musicapp2/screens/register.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final email = TextEditingController();
  final password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login(context) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Fluttertoast.showToast(
          msg: "WELCOME",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
    } on FirebaseAuthException catch (e) {
      print('exception : $e');
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Enter valid password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "Enter valid email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Error login, Please try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login your account')),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                  width: 200,
                  height: 150,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset("assets/images.png")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 0, bottom: 0),
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
            ),
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ForgotPassword()));
            },
            child: Text(
              'Forgot Password',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                login(context);
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: 130,
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Register()));
            },
            child: const Text(
              'New User? Create Account',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        ])));
  }
}
