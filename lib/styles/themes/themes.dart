import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/styles/colors/colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Indie',
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: kMainColor),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 17, fontWeight: FontWeight.w300, color: Colors.black)),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
        fontSize: 22, color: Colors.black, fontWeight: FontWeight.w300),
    color: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0.0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      elevation: 5,
      backgroundColor: Colors.white),
  primarySwatch: Colors.blue,
);
