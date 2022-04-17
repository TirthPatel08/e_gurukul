import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:egurukul/Screens/Dashboard.dart';
import 'package:egurukul/Screens/Login.dart';

class Auth {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          return Login();
        } else {
          return Dashboard();
        }
      },
    );
  }

  signIn(otp, verID, context) {
    AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verID, smsCode: otp);
    FirebaseAuth.instance.signInWithCredential(authCredential).whenComplete((){
      Navigator.pushReplacementNamed(context, Dashboard.id);
    });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}