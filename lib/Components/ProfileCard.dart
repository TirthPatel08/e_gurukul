// import 'package:flutter/material.dart';

// Widget profileCard(BuildContext context, String label, String text, Icon prefixIcon) {
//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(label, style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
//         ],
//       ),
//       Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.blueAccent[700],
//             width: 3,
//           ),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10),
//             bottomLeft: Radius.circular(10),
//           ),
//         ),
//         margin: EdgeInsets.only(left: 20, bottom: 20),
//         child: TextField(
//           readOnly: true,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.only(left: 15),
//             hintText: text,
//             hintStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     ],
//   );
// }

import 'package:flutter/material.dart';

Widget profileCard(String text, IconData icon) {
  return Card(
    shadowColor: Colors.blueAccent[700],
    elevation: 10.0,
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blueAccent[700],
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.blueAccent[700],
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSans'
          ),
        ),
      ),
    ),
  );
}

Widget editProfileCard(BuildContext context, String text, IconData icon, FocusNode focusNode, FocusNode nextFocusNode, TextInputType keyboard, Function onChanged, TextInputAction action) {
  return Card(
    shadowColor: Colors.blueAccent[700],
    elevation: 10.0,
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blueAccent[700],
        ),
        title: TextField(
          textInputAction: action ?? TextInputAction.next,
          focusNode: focusNode,
          onSubmitted: (value) {
            _fieldFocusChange(context, focusNode, nextFocusNode);
          },
          onChanged: onChanged,
          cursorColor: Colors.blueAccent[700],
          keyboardType: keyboard,
          style: TextStyle(
            color: Colors.blueAccent[700],
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSans'),
          decoration: InputDecoration(
            hintText: text,
            border: InputBorder.none,
          ),
        ),
      ),
    ),
  );
}

_fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}