import 'package:flutter/material.dart';
import 'package:egurukul/Components/CustomPainter.dart';

Widget noticeCard(String title, String subtitle) {
  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: ExpansionTile(
      title: Text(title, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700,),),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.blueAccent[700], size: 50,),
      children: [
        Divider(color: Colors.black, height: 3,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(subtitle, softWrap: true, style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
        ),
      ],
    ),
  );
}

class NoticeCard extends StatefulWidget {
  final String title, subtitle;

  NoticeCard({@required this.title, @required this.subtitle});

  @override
  _NoticeCardState createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
  //   return Card(
  //   elevation: 10,
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //   child: ExpansionTile(
  //     title: Text(title, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700,),),
  //     trailing: Icon(Icons.arrow_drop_down, color: Colors.blueAccent[700], size: 50,),
  //     children: [
  //       Divider(color: Colors.black, height: 3,),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         child: Text(subtitle, softWrap: true, style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
  //       ),
  //     ],
  //   ),
  // );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [
                   Color(0xff73A1F9), Color(0xff6DC8F3),
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
            // Positioned(
            //   right: 0,
            //   bottom: 0,
            //   top: 0,
            //   child: CustomPaint(
            //     size: Size(100, 150),
            //     painter: CustomCardShapePainter(24, Color(0xff6DC8F3), Color(0xff73A1F9)),
            //   ),
            // ),
            GestureDetector(
              onTap: (){setState(() {isExpanded = !isExpanded;});},
              child: Positioned.fill(
                child: ExpansionTile(
                  title: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700,),),
                  trailing: Icon(Icons.arrow_drop_down, color: Colors.blueAccent[700], size: 50,),
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(widget.subtitle, softWrap: true, style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardNotice extends StatefulWidget {
  final String title, subtitle;
  DashboardNotice({@required this.title, @required this.subtitle});

  @override
  _DashboardNoticeState createState() => _DashboardNoticeState();
}

class _DashboardNoticeState extends State<DashboardNotice> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
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
                  Expanded(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 64,
                      width: 64,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Description: ${widget.subtitle}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 15
                          ),
                        ),                        
                      ],
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