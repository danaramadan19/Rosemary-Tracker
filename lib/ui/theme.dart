import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF80C038);
const Color orangeClr = Colors.lightBlue;
const Color pinkClr = Color(0xFFF9A5A5);
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );
}