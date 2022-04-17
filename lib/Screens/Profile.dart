import 'package:flutter/material.dart';
import 'package:egurukul/Components/CustomAppBar.dart';
import 'package:egurukul/Components/ProfileCard.dart';
import 'package:egurukul/Components/RaisedBtn.dart';
import 'package:egurukul/Screens/UpdateProfile.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class Profile extends StatefulWidget {
  static final String id = "Profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              profileCard(name.toString(), Icons.person_outline),
              profileCard(id.toString(), Icons.assignment_ind_outlined),
              profileCard(phone.toString(), Icons.phone_android),
              SizedBox(height: 20,),
              kRaisedButton(
                MediaQuery.of(context).size.width*0.75, "Edit Profile",
                () {Navigator.pushNamed(context, UpdateProfile.id);}
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}