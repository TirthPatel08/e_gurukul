import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:egurukul/Components/CustomAppBar.dart';
import 'package:egurukul/Components/RaisedBtn.dart';
import 'package:egurukul/Components/TextField.dart';
import 'package:egurukul/Screens/Notice.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class AddNotice extends StatefulWidget {
  static final String id = "AddNotice";
  @override
  _AddNoticeState createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  FocusNode titleFN, subtitleFN;
  String title, subtitle;
  bool isLoading = false;

  @override
  void initState() {
    titleFN = FocusNode();
    subtitleFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    titleFN.dispose();
    subtitleFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Add Notice"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Center(child: Text("Add new Notice!!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
              SizedBox(height: 30,),
              kTextField(context, "Notice Title", Icon(Icons.title), titleFN, subtitleFN, TextInputType.text, (value){title = value;}, null),
              SizedBox(height: 20,),
              kTextField(context, "Notice Description", Icon(Icons.description), subtitleFN, null, TextInputType.text, (value){subtitle = value;}, TextInputAction.done),
              SizedBox(height: 25,),
              isLoading
                ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                : kRaisedButton(200, "Add", () {check();}),
              SizedBox(height: 10,),
            ],
          )
        ),
      ),
    );
  }

  void check() {
    if(title == null || subtitle == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(title.length >= 25) {
      Fluttertoast.showToast(msg: "Maximum length of title is 25...");
    } else {
      setState(() {isLoading = true;});
      collectionReference.doc("Notice").collection(date).doc().set({
        "title": title,
        "subtitle": subtitle,
      }).then((value) {
        setState(() {isLoading = false;});
        Fluttertoast.showToast(msg: "New Notice Added!");
        Navigator.popAndPushNamed(context, Notice.id);
      });
    }
  }
}