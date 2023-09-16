import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Colors.blue;
  static ThemeData LgihtTheme = ThemeData(
      primarySwatch: Colors.blue,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
            size: 28,
          ),
          selectedIconTheme: IconThemeData(size: 31, color: Colors.blue)));
}
