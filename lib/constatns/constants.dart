import 'package:flutter/material.dart';

const kTextfieldDecoratin = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(color: Colors.black45),
  contentPadding: EdgeInsets.only(left: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF678983), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF678983), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kBackgroundColor = Color(0xFFF0E9D2);
const kWidgetColor = Color(0xFF678983);
const kLabelTextStyle =
    TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700);
const String googleApiKey = 'AIzaSyB4xlDfkaFa9xMTajKuPjfVn0ml2flnRww';
