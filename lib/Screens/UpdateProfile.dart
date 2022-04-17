import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:egurukul/Components/ConnectivityCheck.dart';
import 'package:egurukul/Components/CustomAppBar.dart';
import 'package:egurukul/Components/ProfileCard.dart';
import 'package:egurukul/Components/RaisedBtn.dart';
import 'package:egurukul/Components/TextField.dart';
import 'package:egurukul/Screens/Dashboard.dart';
import 'package:egurukul/Screens/Login.dart';
import 'package:egurukul/Screens/Profile.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class UpdateProfile extends StatefulWidget {
  static final String id = "UpdateProfile";
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  FocusNode nameFN, idFN;
  String nameup, idup;
  bool isLoading = false;

  @override
  void initState() {
    nameFN = FocusNode();
    idFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    nameFN.dispose();
    idFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Update Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Image.asset("assets/logo.png"),
              ),
              Text(
                "E-Gurukul",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueAccent[700],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bitter',
                ),
              ),
              SizedBox(height: 20,),
              editProfileCard(context, name, Icons.person_outline, nameFN, idFN, TextInputType.name, (value){nameup = value;}, null),
              editProfileCard(context, id, Icons.assignment_ind_outlined, idFN, null, TextInputType.text, (value){idup = value;}, TextInputAction.done),
              profileCard(phone, Icons.phone_android),
              SizedBox(height: 20,),
              kRaisedButton(MediaQuery.of(context).size.width*0.75, "Update Profile", () {check();}),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  void check() {
    setState(() {isLoading = true;});
    collectionReference = FirebaseFirestore.instance.collection(classcode);
    if(isAdmin) {
      collectionReference.doc("Admin").update({
        "name": nameup ?? name,
        "id": idup ?? id,
      });
    }
    collectionReference.doc(phonesp).update({
      "name": nameup ?? name,
      "id": idup ?? id,
    }).then((value) {
      Fluttertoast.showToast(msg: "Profile updated Succefully");
      Navigator.popAndPushNamed(context, Dashboard.id);
    }).onError((error, stackTrace) => 
      Fluttertoast.showToast(msg: "Profile updated Failed")
    );
  }
}