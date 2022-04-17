import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:egurukul/Components/ConnectivityCheck.dart';
import 'package:egurukul/Components/RaisedBtn.dart';
import 'package:egurukul/Components/TextField.dart';
import 'package:egurukul/Screens/Dashboard.dart';
import 'package:egurukul/Screens/SignUp.dart';
import 'package:egurukul/Screens/ClassRegister.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class Login extends StatefulWidget {
  static final String id = "Login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode classcodeFN, phoneFN, passwordFN;
  String classcode, phone, password;
  bool isLoading = false;

  @override
  void initState() {
    classcodeFN = FocusNode();
    phoneFN = FocusNode();
    passwordFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    classcodeFN.dispose();
    phoneFN.dispose();
    passwordFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ConnectivityCheck(
          childView: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                Image.asset("assets/logo.png", height: 150),
                SizedBox(height: 10,),
                Center(child: Text("Welcome back!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
                SizedBox(height: 25,),
                kTextField(context, "Class Code", Icon(Icons.code), classcodeFN, phoneFN, TextInputType.text, (value){classcode = value;}, null),
                SizedBox(height: 25,),
                kTextField(context, "Phone Number", Icon(Icons.phone_android_outlined), phoneFN, passwordFN, TextInputType.phone, (value){phone = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Password", Icon(Icons.lock_outline), passwordFN, null, TextInputType.text, (value){password = value;}, TextInputAction.done),
                SizedBox(height: 25,),
                isLoading
                  ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                  : kRaisedButton(150, "LOG IN", () {check();}),
                SizedBox(height: 30,),
                Center(child: Text("Class not registered??", style: TextStyle(color: Colors.grey),)),
                SizedBox(height: 5,),
                kRaisedButton(250, "Register Class", () {Navigator.pushNamed(context, ClassRegister.id);}),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account? ", style: TextStyle(color: Colors.black87,),),
                    GestureDetector(
                      onTap: () {Navigator.pushNamed(context, SignUp.id);},
                      child: Text("Sign Up", style: TextStyle(color: Colors.blueAccent[700], fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void check() {
    if(phone == null || password == null || classcode == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(phone.length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
    } else {
      setState(() {isLoading = true;});
      collectionReference = FirebaseFirestore.instance.collection(classcode);
      collectionReference.doc(phone).get().then((value) {
        if(password != value["password"]) {
          setState(() {isLoading = false;});
          Fluttertoast.showToast(msg: "Incorrect Password");
        } else {
          sharedpref.setString('classcode', classcode);
          sharedpref.setString('phone', phone);
          Navigator.popAndPushNamed(context, Dashboard.id);
        }
      }).onError((error, stackTrace) {
          setState(() {isLoading = false;});
          Fluttertoast.showToast(msg: "Account with this details doesn't exists", backgroundColor: Colors.red);
        }
      );
    }
  }
}