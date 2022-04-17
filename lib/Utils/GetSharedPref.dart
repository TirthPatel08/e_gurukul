import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedpref;
String namesp, phonesp, idsp, classcodesp;

initial() async {
  sharedpref = await SharedPreferences.getInstance();
  namesp = sharedpref.getString('name');
  phonesp = sharedpref.getString('phone');
  idsp = sharedpref.getString('id');
  classcodesp = sharedpref.getString('classcodesp');
}