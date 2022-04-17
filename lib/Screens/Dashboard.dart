import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:egurukul/Components/ConnectivityCheck.dart';
import 'package:egurukul/Components/DashbardCard.dart';
import 'package:egurukul/Components/NoticeCard.dart';
import 'package:egurukul/Screens/Contacts.dart';
import 'package:egurukul/Screens/Login.dart';
import 'package:egurukul/Screens/Notice.dart';
import 'package:egurukul/Screens/Profile.dart';
import 'package:egurukul/Screens/Queries.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class Dashboard extends StatefulWidget {
  static final String id = "Dashboard";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    initial();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent[700],
          centerTitle: true,
          title: FutureBuilder(
            future: getData(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Text(
                  "Hello!!!",
                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.white)),
                );
              } else {
                return Text(
                  "Hello $name!!!",
                  softWrap: true,
                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.white)),
                );
              }
            }
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                sharedpref.clear();
                Navigator.pushReplacementNamed(context, Login.id);
              }
            ),
          ],
        ),
        body: ConnectivityCheck(
          childView: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dashboardCard(context, "Notice", "notices", (){Navigator.pushNamed(context, Notice.id);}),
                  dashboardCard(context, "Queries", "queries", (){Navigator.pushNamed(context, Queries.id);}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dashboardCard(context, "Contacts", "contacts", (){Navigator.pushNamed(context, Contacts.id);}),
                  dashboardCard(context, "Profile", "profile", (){Navigator.pushNamed(context, Profile.id);}),
                ],
              ),
              // Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(10),
              //       child: Container(
              //         width: MediaQuery.of(context).size.width*0.5,
              //         decoration: BoxDecoration(
              //           color: Colors.blueAccent[700],
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 5),
              //           child: Center(child: Text("Notices", style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              //         )
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: (){Navigator.pushNamed(context, Notice.id);},
              //       child: Container(
              //         // decoration: BoxDecoration(
              //         //   borderRadius: BorderRadius.circular(20),
              //         //   color: Colors.white,
              //         //   boxShadow: [
              //         //     BoxShadow(
              //         //       color: Colors.black26,
              //         //       blurRadius: 5,
              //         //       spreadRadius: 0.7,
              //         //       offset: Offset(-2, 2),
              //         //     ),
              //         //   ]
              //         // ),
              //         height: MediaQuery.of(context).size.height*0.30,
              //         width: MediaQuery.of(context).size.width,
              //         // child: FutureBuilder(
              //         //   future: getData(),
              //         //   builder: (context, snapshot) {
              //         //     if(snapshot.connectionState == ConnectionState.waiting) {
              //         //       return Center(child: CircularProgressIndicator(),);
              //         //     } else {
              //         //       return Column(
              //         //         mainAxisAlignment: MainAxisAlignment.center,
              //         //         crossAxisAlignment: CrossAxisAlignment.center,
              //         //         children: [
              //         //           Container(
              //         //             child: Padding(
              //         //               padding: const EdgeInsets.all(8.0),
              //         //               child: Text(
              //         //                 title[0].toString() ?? 'No Notice Yet!!!',
              //         //                 style: Theme.of(context).textTheme.headline5.merge(
              //         //                   TextStyle(
              //         //                     fontFamily: 'Lora',
              //         //                     fontWeight: FontWeight.bold,
              //         //                   ),
              //         //                 ),
              //         //               ),
              //         //             ),
              //         //           ),
              //         //           Padding(
              //         //             padding: const EdgeInsets.all(8.0),
              //         //             child: Text(
              //         //               subtitle[0].toString() ?? '',
              //         //               softWrap: true,
              //         //               maxLines: 3,
              //         //               overflow: TextOverflow.ellipsis,
              //         //               style: Theme.of(context).textTheme.headline6.merge(
              //         //                 TextStyle(
              //         //                   fontFamily: 'Lora',
              //         //                 ),
              //         //               ),
              //         //             ),
              //         //           ),
              //         //         ],
              //         //       );
              //         //     }
              //         //   },
              //         // ),
              //         child: Column(
              //           children: [
              //             StreamBuilder<QuerySnapshot>(
              //               stream: collectionReference.doc("Notice").collection(date).limit(1).snapshots(),
              //               builder: (context, snapshot) {
              //                 if(snapshot.connectionState == ConnectionState.waiting) {
              //                   return CircularProgressIndicator();
              //                 } else {
              //                   if(snapshot.hasData) {
              //                     final notices = snapshot.data.docs;
              //                     List<DashboardNotice> noticesCards = [];
              //                     for (var notice in notices) {
              //                       final noticetitle = notice['title'];
              //                       final noticesubtitle = notice['subtitle'];
              //                       final noticesCard = DashboardNotice(title: noticetitle, subtitle: noticesubtitle,);
              //                       noticesCards.add(noticesCard);
              //                     }
              //                     return Expanded(child: ListView(children: noticesCards,));
              //                   } else if(!snapshot.hasData) {
              //                     return Center(child: Text("No Notices Yet!!!"),);
              //                   }
              //                   return Container();
              //                 }
              //               }
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            
            ],
          ),
        ),
      ),
    );
  }
}