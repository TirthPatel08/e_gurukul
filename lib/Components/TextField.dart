import 'package:flutter/material.dart';

Widget kTextField (BuildContext context, String labelText, Icon prefixIcon, FocusNode focusNode, FocusNode nextFocusNode, TextInputType keyboard, Function onChanged, TextInputAction action) {
  return Material(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: TextField(
      textInputAction: action ?? TextInputAction.next,
      focusNode: focusNode,
      onSubmitted: (value) {
        _fieldFocusChange(context, focusNode, nextFocusNode);
      },
      onChanged: onChanged,
      obscureText: labelText == 'Password' ? true : false,
      cursorColor: Colors.blueAccent[700],
      keyboardType: keyboard,
      style: TextStyle(color: Colors.blueAccent[700]),
      decoration: InputDecoration(
        focusColor: Colors.blueAccent[700],
        labelText: labelText,
        labelStyle: TextStyle(color: focusNode.hasFocus ? Colors.blueAccent[700] : Colors.grey),
        prefixIcon: prefixIcon,
        prefixStyle: TextStyle(color: Colors.blueAccent[700]),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent[700], width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

_fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}