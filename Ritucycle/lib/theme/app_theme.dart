import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.pink,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pinkAccent),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 5,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  );
}
