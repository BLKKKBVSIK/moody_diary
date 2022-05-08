import 'package:flutter/material.dart';

final livnTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 28,
    ),
    headline2: TextStyle(
      color: Colors.blue,
      fontSize: 20,
    ),
    headline3: TextStyle(
      color: Colors.blue,
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: Colors.indigo, shape: const StadiumBorder(), elevation: 0)),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(30))),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
);
