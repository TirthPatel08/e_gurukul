import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:egurukul/Components/ConnectivityCheck.dart';
import 'package:egurukul/Components/RaisedBtn.dart';
import 'package:egurukul/Components/TextField.dart';
import 'package:egurukul/Screens/Dashboard.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class ClassRegister extends StatefulWidget {
  static final String id = "ClassRegister";
  @override
  _ClassRegisterState createState() => _ClassRegisterState();
}

class _ClassRegisterState extends State<ClassRegister> {
  FocusNode classFN, facultyFN, facultyidFN, phoneFN, passwordFN, classcodeFN;
  String className, faculty, facid, phone, password, classcode;
  bool isLoading = false;

  @override
  void initState() {
    classFN = FocusNode();
    facultyFN = FocusNode();
    facultyidFN = FocusNode();
    phoneFN = FocusNode();
    passwordFN = FocusNode();
    classcodeFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    classFN.dispose();
    facultyFN.dispose();
    facultyidFN.dispose();
    phoneFN.dispose();
    passwordFN.dispose();
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
                kTextField(context, "Class Name", Icon(Icons.class__outlined), classFN, classcodeFN, TextInputType.text, (value){className = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Class Code", Icon(Icons.code), classcodeFN, facultyFN, TextInputType.text, (value){classcode = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Faculty Name", Icon(Icons.person_outline), facultyFN, facultyidFN, TextInputType.name, (value){faculty = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Faculty ID", Icon(Icons.assignment_ind_outlined), facultyidFN, phoneFN, TextInputType.name, (value){facid = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Phone Number", Icon(Icons.phone_android_outlined), phoneFN, passwordFN, TextInputType.phone, (value){phone = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Password", Icon(Icons.lock_outline), passwordFN, null, TextInputType.text, (value){password = value;}, TextInputAction.done),
                SizedBox(height: 25,),
                isLoading
                  ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                  : kRaisedButton(200, "REGISTER", () {check();}),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),      
      ),
    );
  }

  void check() {
    if(className == null || classcode == null || faculty == null || facid == null|| phone == null || password == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(phone.length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
    } else {
      setState(() {isLoading = true;});
      // !codeSent
      //   ? verify(phone)
      //   : 
        collectionReference = FirebaseFirestore.instance.collection(classcode);
          collectionReference.doc("Admin").set({
            "className": className,
            "name": faculty,
            "id": facid,
            "phone": phone,
            "classcode": classcode
          });
          collectionReference.doc(phone).set({
            "name": faculty,
            "id": facid,
            "password": password
          }).then((value) {
            sharedpref.setString('name', faculty);
            sharedpref.setString('phone', phone);
            sharedpref.setString('id', facid);
            sharedpref.setString('classcode', classcode);
            Navigator.popAndPushNamed(context, Dashboard.id);
          });
    }
  }

  // Future<void> verify(phone) async {
  //   final PhoneVerificationCompleted verified = (AuthCredential authResult) {
  //     Auth().signIn(classcode, verificationID, context);
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