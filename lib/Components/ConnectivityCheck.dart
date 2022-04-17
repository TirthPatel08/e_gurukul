import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class ConnectivityCheck extends StatefulWidget {
  final Widget childView;
  ConnectivityCheck({@required this.childView});

  @override
  _ConnectivityCheckState createState() => _ConnectivityCheckState();
}

class _ConnectivityCheckState extends State<ConnectivityCheck> {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          return OfflineBuilder(
            connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  Positioned(left: 0, right: 0, height: 32.0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: connected ? Colors.transparent : Color(0xFFEE4400),
                      child: connected ? Container() 
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("OFFLINE", style: TextStyle(color: Colors.white),),
                                SizedBox(width: 10,),
                                SizedBox(
                                  width: 12.0,
                                  height: 12.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              );
            },
            child: widget.childView,
          );
        },
      );
  }
}