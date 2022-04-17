import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:egurukul/Screens/AddQuery.dart';
import 'package:egurukul/Screens/Queries.dart';
import 'package:egurukul/Screens/AddNotice.dart';
import 'package:egurukul/Screens/Contacts.dart';
import 'package:egurukul/Screens/Dashboard.dart';
import 'package:egurukul/Screens/UpdateProfile.dart';
import 'package:egurukul/Screens/Login.dart';
import 'package:egurukul/Screens/Notice.dart';
import 'package:egurukul/Screens/Profile.dart';
import 'package:egurukul/Screens/SignUp.dart';
import 'package:egurukul/Screens/ClassRegister.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        ClassRegister.id: (context) => ClassRegister(),
        Dashboard.id: (context) => Dashboard(),
        Contacts.id: (context) => Contacts(),
        Profile.id: (context) => Profile(),
        UpdateProfile.id: (context) => UpdateProfile(),
        Notice.id: (context) => Notice(),
        Queries.id: (context) => Queries(),
        AddNotice.id: (context) => AddNotice(),
        AddQuery.id: (context) => AddQuery(),
      }
    );
  }
}

class SplashScreen extends StatefulWidget {
  static final String id = "SplashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    initial();
    Timer(Duration(seconds: 4), () => checkIfAlreadyLoggedin());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/logo.png", height: 200,),
          SizedBox(height: 30,),
          Center(child: Text("E-Gurukul!!!", style: TextStyle(color: Colors.blueAccent[700], fontSize: 50, fontWeight: FontWeight.bold, fontFamily: "Allura"),)),
          SizedBox(height: 3,),
          Text("Excellence has no Limits...", style: TextStyle(color: Colors.blueAccent[700], fontSize: 15, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          SizedBox(height: 50,),
          SpinKitRipple(color: Colors.blueAccent[700], size: 60),
        ],
      ),
    );
  }

  void checkIfAlreadyLoggedin() {
    if(sharedpref.getString('classcode') != null && sharedpref.getString('phone') != null) {
      Navigator.pushReplacementNamed(context, Dashboard.id);
    } else {
      Navigator.pushReplacementNamed(context, Login.id);
    }
  }
}