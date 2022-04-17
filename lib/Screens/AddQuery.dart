import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:egurukul/Components/CustomAppBar.dart';
import 'package:egurukul/Components/RaisedBtn.dart';
import 'package:egurukul/Components/TextField.dart';
import 'package:egurukul/Screens/Notice.dart';
import 'package:egurukul/Screens/Queries.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class AddQuery extends StatefulWidget {
  static final String id = "AddQuery";
  @override
  _AddQueriestate createState() => _AddQueriestate();
}

class _AddQueriestate extends State<AddQuery> {
  FocusNode titleFN, descriptionFN;
  String title, description;
  bool isLoading = false;

  @override
  void initState() {
    titleFN = FocusNode();
    descriptionFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    titleFN.dispose();
    descriptionFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Register Query"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Center(child: Text("Register Query!!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
              SizedBox(height: 30,),
              kTextField(context, "Query Title", Icon(Icons.title), titleFN, descriptionFN, TextInputType.text, (value){title = value;}, null),
              SizedBox(height: 20,),
              kTextField(context, "Query Description", Icon(Icons.description), descriptionFN, null, TextInputType.text, (value){description = value;}, TextInputAction.done),
              SizedBox(height: 25,),
              isLoading
                ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                : kRaisedButton(200, "Register", () {check();}),
              SizedBox(height: 10,),
            ],
          )
        ),
      ),
    );
  }

  void check() {
    if(title == null || description == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(title.length >= 25) {
      Fluttertoast.showToast(msg: "Maximum length of title is 25...");
    } else {
      setState(() {isLoading = true;});
      collectionReference.doc("Query").collection(date).doc().set({
        "querytitle": title,
        "querydescription": description,
        "questioner": name,
        "questionerid": id,
      }).then((value) {
        setState(() {isLoading = false;});
        Fluttertoast.showToast(msg: "New Query Registered!");
        Navigator.popAndPushNamed(context, Queries.id);
      });
    }
  }
}