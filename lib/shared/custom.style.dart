import 'package:flutter_web/material.dart';

const cBodyText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.blueGrey,
);

const cHeaderText = TextStyle(
    color: Colors.white70,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

const cHeaderDarkText = TextStyle(
    color: Colors.blueGrey,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

var cThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  primarySwatch: Colors.blue,
  buttonColor: Colors.blue,
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
);

const cAppTitle = "Food Court";
