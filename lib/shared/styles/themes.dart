import 'package:flutter/material.dart';
import 'package:pomodoro_app/shared/constants.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  iconTheme: IconThemeData(
    color: Colors.white,
    size: 40,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: kHeavyPurpleColor,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    elevation: 0.0,
    unselectedIconTheme: IconThemeData(
      opacity: 0.6,
      color: kHeavyPinkColor,
    ),
    selectedIconTheme: IconThemeData(
      color: kHeavyPinkColor,
      size: 50,
      opacity: 1,
    ),
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    selectedItemColor: Colors.blueGrey,
    unselectedItemColor: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color.fromRGBO(24, 25, 26, 1),
  brightness: Brightness.dark,
  iconTheme: IconThemeData(
    color: Colors.white,
    size: 40,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(24, 25, 26, 1),
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    elevation: 0.0,
    unselectedIconTheme: IconThemeData(
      opacity: 0.6,
      color: Colors.white,
    ),
    selectedIconTheme: IconThemeData(
      color: Colors.white,
      size: 50,
      opacity: 1,
    ),
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black,
  ),
);