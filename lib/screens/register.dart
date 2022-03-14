// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicapp2/screens/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final username = TextEditingController();
  final email = TextEditingController();
  final password1 = TextEditingController();
  final password2 = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {},
  );

  Future register(context) async {
    if (password1.text != password2.text) {
      Fluttertoast.showToast(
          msg: "Passwords dont match !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email.text, password: password2.text);
      Fluttertoast.showToast(
          msg: "User Created Successfully... Please login!!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("EXCEPTION: $e");
      Fluttertoast.showToast(
          msg: "Error creating account, Please try again later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Create New Acoount')),
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
                  child: Image.asset("assets/register-png-1.png")),
            ),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: username,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter Username',
                  errorText: "Username required"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            // padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter valid email id as abc@gmail.com',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: password1,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: password2,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  hintText: 'Enter same password'),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: FlatButton(
              onPressed: () {
                register(context);
              },
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Login()));
            },
            child: Text(
              'Already have an account? Login',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        ])));
  }
}
