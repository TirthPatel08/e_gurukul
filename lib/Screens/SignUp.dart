import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:egurukul/Components/ConnectivityCheck.dart';
import 'package:egurukul/Components/RaisedBtn.dart';
import 'package:egurukul/Components/TextField.dart';
import 'package:egurukul/Screens/Dashboard.dart';
import 'package:egurukul/Screens/Login.dart';
import 'package:egurukul/Services/auth.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class SignUp extends StatefulWidget {
  static final String id = "Sign Up";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FocusNode nameFN, phoneFN, idFN, classcodeFN, passwordFN;
  String name, phone, id, classcode, password;
  bool isLoading = false;

  @override
  void initState() {
    nameFN = FocusNode();
    phoneFN = FocusNode();
    idFN = FocusNode();
    classcodeFN = FocusNode();
    passwordFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    nameFN.dispose();
    phoneFN.dispose();
    idFN.dispose();
    classcodeFN.dispose();
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
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);},),
                  ],
                ),
                SizedBox(height: 10,),
                Center(child: Text("Let's Get Started!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
                SizedBox(height: 30,),
                kTextField(context, "Full Name", Icon(Icons.person_outline), nameFN, phoneFN, TextInputType.name, (value){name = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Phone Number", Icon(Icons.phone_android_outlined), phoneFN, idFN, TextInputType.phone, (value){phone = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "ID Number", Icon(Icons.assignment_ind_outlined), idFN, passwordFN, TextInputType.text, (value){id = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Password", Icon(Icons.lock_outline), passwordFN, classcodeFN, TextInputType.text, (value){password = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Class Code", Icon(Icons.code), classcodeFN, null, TextInputType.text, (value){classcode = value;}, TextInputAction.done),
                SizedBox(height: 25,),
                isLoading
                  ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                  : kRaisedButton(150, "CREATE", () {check();}),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account? ", style: TextStyle(color: Colors.black87,),),
                    GestureDetector(
                      onTap: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));},
                      child: Text("Login here", style: TextStyle(color: Colors.blueAccent[700], fontWeight: FontWeight.w600),),
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
    if(name == null || phone == null || password == null || id == null || classcode == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(phone.length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
    } else {
      setState(() {isLoading = true;});
      // !codeSent
      //   ? verify(phone)
      //   : 
        collectionReference = FirebaseFirestore.instance.collection(classcode);
          collectionReference.doc(phone).set({
            "name": name,
            "id": id,
            "password": password
          }).then((value) {
            sharedpref.setString('name', name);
            sharedpref.setString('classcode', classcode);
            sharedpref.setString('id', id);
            sharedpref.setString('phone', phone);
            Navigator.popAndPushNamed(context, Dashboard.id);
          });
    }
  }

  // Future<void> verify(phone) async {
  //   final PhoneVerificationCompleted verified = (AuthCredential authResult) {
  //     Auth().signIn(otp, verificationID, context);
  //   };

  //   final PhoneVerificationFailed failed = (FirebaseAuthException authFailed) {
  //     setState(() {isLoading = false;});
  //     Fluttertoast.showToast(msg: "${authFailed.message}");
  //   };

  //   final PhoneCodeSent smsSent = (String verID, [int forceResend]) {
  //     setState(() {isLoading = false;});
  //     Fluttertoast.showToast(msg: "Code Sent");
  //     setState(() {
  //       verificationID = verID;
  //       codeSent = true;
  //     });
  //   };

  //   final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verID) {
  //     verificationID = verID;
  //   };

  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: "+91$phone",
  //     verificationCompleted: verified,
  //     verificationFailed: failed,
  //     codeSent: smsSent,
  //     timeout: Duration(seconds: 5),
  //     codeAutoRetrievalTimeout: autoTimeout,
  //   );
  // }

}