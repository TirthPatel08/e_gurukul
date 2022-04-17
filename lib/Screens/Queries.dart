import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:egurukul/Components/QueryCard.dart';
import 'package:egurukul/Components/ConnectivityCheck.dart';
import 'package:egurukul/Components/CustomAppBar.dart';
import 'package:egurukul/Screens/AddQuery.dart';
import 'package:egurukul/Screens/Login.dart';
import 'package:egurukul/Utils/GetDetails.dart';
import 'package:egurukul/Utils/GetSharedPref.dart';

class Queries extends StatefulWidget {
  static final String id = "Complaints";
  @override
  _QueriesState createState() => _QueriesState();
}

class _QueriesState extends State<Queries> {
  String selecteddate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Queries"),
          backgroundColor: Colors.blueAccent[700],
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                final now = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1960),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2100));
                if(date != null) {
                  var formatter = new DateFormat('yyyy-MM-dd');
                  setState(() {
                    selecteddate = formatter.format(now);
                  });
                }
              }
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                sharedpref.clear();
                Navigator.pushReplacementNamed(context, Login.id);
              }
            ),
          ],
        ),
        // body: ConnectivityCheck(
        //   childView: FutureBuilder(
        //     future: getData(),
        //     builder: (context, snapshot) {
        //       if(snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator(),);
        //       } else if(snapshot == null) {
        //         return Center(child: Text("No Complaints Registered Yet!!!"),);
        //       } else {
        //         return Padding(
        //           padding: const EdgeInsets.all(3),
        //           child: ListView.separated(
        //             separatorBuilder: (context, index) => SizedBox(height: 5,),
        //             itemCount: complainttitle.length,
        //             itemBuilder: (context, index) {
        //               return complaintCard(complainttitle[index], complaintsubtitle[index], complainee[index], complaineeflat[index]);
        //             },
        //           ),
        //         );
        //       }
        //     },
        //   ),
        // ),
        body: ConnectivityCheck(
          childView: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: collectionReference.doc("Query").collection(selecteddate ?? date).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    // print(snapshot.hasData);
                    // print(!snapshot.hasData);
                    if(snapshot.hasData) {
                      final queries = snapshot.data.docs;
                      List<QueryCard> queriesCards = [];
                      for (var query in queries) {
                        final querytitle = query['querytitle'];
                        final querydescription = query['querydescription'];
                        final questioner = query['questioner'];
                        final questionerid = query['questionerid'];
                        final queriesCard = QueryCard(title: querytitle, description: querydescription, questioner: questioner, questionerid: questionerid,);
                        queriesCards.add(queriesCard);
                      }
                      if(queriesCards.length == 0) {
                        return Center(child: Image.asset("assets/nodata.jpg"),);
                      } else {
                        return Expanded(
                          child: ListView(
                            children: queriesCards,
                          ),
                        );
                      }
                      // return Expanded(child: ListView(children: queriesCards,));
                    } else if(!snapshot.hasData) {
                      return Center(child: Text("No queries Registered Yet!!!"),);
                    }
                  }
                  return Container();
                }
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent[700],
          child: Icon(Icons.add),
          onPressed: (){Navigator.popAndPushNamed(context, AddQuery.id);},
        ),
      ),
    );
  }
}