import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey,
    titleTextStyle: TextStyle(color: Colors.white,fontSize:18),
    centerTitle: true,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey,
    foregroundColor: Colors.white
  )
);