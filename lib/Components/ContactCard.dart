import 'package:flutter/material.dart';
import 'package:egurukul/Components/CustomPainter.dart';
import 'package:url_launcher/url_launcher.dart';

// Widget contactCard(String name, String id, String phone) {
//   // return Card(
//   //   elevation: 10,
//   //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//   //   child: ListTile(
//   //     title: Text(name, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),
//   //     subtitle: Text(id, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500,), textAlign: TextAlign.center,),
//   //     leading: CircleAvatar(child: Icon(Icons.person, color: Colors.white,), backgroundColor: Colors.blueAccent[700],),
//   //     trailing: CircleAvatar(
//   //       child: IconButton(
//   //         icon: Icon(Icons.phone, color: Colors.green,),
//   //         onPressed: ()=> launch("tel: $phone"),
//   //       ),
//   //       backgroundColor: Colors.white,
//   //     ),
//   //   ),
//   // );
//   return Center(
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             height: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24),
//               gradient: LinearGradient(colors: [
//                 Color(0xff6DC8F3), Color(0xff73A1F9)
//               ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//               boxShadow: [
//                 BoxShadow(
//                   color:  Color(0xff73A1F9),
//                   blurRadius: 12,
//                   offset: Offset(0, 6),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 0,
//             bottom: 0,
//             top: 0,
//             child: CustomPaint(
//               size: Size(100, 150),
//               painter: CustomCardShapePainter(24, Color(0xff6DC8F3), Color(0xff73A1F9)),
//             ),
//           ),
//           Positioned.fill(
//             child: Row(
//               children: <Widget>[
//                 Expanded(flex: 1, child: Image.asset("assets/logo.png")),
//                 Expanded(
//                   flex: 4,
//                   child: ListTile(
//                     title: Text(name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),
//                     subtitle: Text(id, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500,), textAlign: TextAlign.center,),
//                     trailing: CircleAvatar(
//                       child: IconButton(
//                         icon: Icon(Icons.phone, color: Colors.green,),
//                         onPressed: ()=> launch("tel: $phone"),
//                       ),
//                       backgroundColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

class ContactCard extends StatelessWidget {
  final String name, id, phone;
  ContactCard({@required this.name, @required this.id, @required this.phone});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [
                  Color(0xff6DC8F3), Color(0xff73A1F9)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color:  Color(0xff73A1F9),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomPaint(
                size: Size(100, 150),
                painter: CustomCardShapePainter(24, Color(0xff6DC8F3), Color(0xff73A1F9)),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: <Widget>[
                  Expanded(flex: 1, child: Icon(Icons.account_circle, color: Colors.blueAccent[700], size: 50,)),
                  // Expanded(flex: 1, child: Image.asset("assets/logo.png")),
                  Expanded(
                    flex: 4,
                    child: ListTile(
                      title: Text(name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),
                      subtitle: Text("ID: $id", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500,), textAlign: TextAlign.center,),
                      trailing: CircleAvatar(
                        child: IconButton(
                          icon: Icon(Icons.phone, color: Colors.green,),
                          onPressed: ()=> launch("tel: $phone"),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}