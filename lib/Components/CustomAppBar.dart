import 'package:flutter/material.dart';
import 'package:egurukul/Screens/Login.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

Widget appBar(BuildContext context, String text) {
  return AppBar(
    title: Text(text),
    backgroundColor: Colors.blueAccent[700],
    actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          sharedpref.clear();
          Navigator.pushReplacementNamed(context, Login.id);
        }
      ),
    ],
  );
}