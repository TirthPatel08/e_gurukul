import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String date = formatter.format(now);

bool isAdmin = false;
String name, facname, id, facid, className, classcode, phone, facphone;
List title = List(), description = List();
// List complainttitle = List(), Queriedescription = List(), complainee = List(), complaineeid = List();
List contactid = List(), contactname = List(), contactphone = List();
CollectionReference collectionReference = FirebaseFirestore.instance.collection(classcodesp);

getData() async {
  if(facphone == phonesp) isAdmin = true;
  else isAdmin = false;

  final memberdata = await collectionReference.doc(phonesp).get();
  name = memberdata['name'];
  id = memberdata['id'];
  phone = memberdata.id;

  final admindata = await collectionReference.doc("Admin").get();
  className = admindata['className'];
  facname = admindata['name'];
  facid = admindata['id'];
  facphone = admindata['phone'];
  classcode = admindata['classcode'];

  // final noticelist = await collectionReference.doc("Notice").collection(date).get();
  // noticelist.docs.forEach((document) {
  //   title.add(document['title']);
  //   description.add(document['description']);
  // });

  // final complaintlist = await collectionReference.doc("Complaint").collection(date).get();
  // complaintlist.docs.forEach((document) {
  //   complainttitle.add(document['complainttitle']);
  //   Queriedescription.add(document['Queriedescription']);
  //   complainee.add(document['complainee']);
  //   complaineeid.add(document['complaineeid']);
  // });

  final contacts = await collectionReference.get();
  contacts.docs.forEach((document) {
    if(document.id == "Admin") {
      return;
    } else if(document.id == "Notice") {
      return;
    } else if(document.id == "Bill") {
      return;
    } else {
      contactname.add(document['name']);
      contactid.add(document['idno']);
      contactphone.add(document.id);
    }
  });

  title = title.toSet().toList();
  description = description.toSet().toList();
  
  // complainttitle = complainttitle.toSet().toList();
  // Queriedescription = Queriedescription.toSet().toList();
  // complainee = complainee.toSet().toList();
  // complaineeid = complaineeid.toSet().toList();

  contactname = contactname.toSet().toList();
  contactid = contactid.toSet().toList();
  contactphone = contactphone.toSet().toList();
}