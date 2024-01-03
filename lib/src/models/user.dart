import 'package:flutter/material.dart';

class User{
  late String name;
  late String mail;

  ///dark or light mode
  ThemeMode lightMode = ThemeMode.dark;
  /// Simple (list) or complex (grid)
  bool simpleMode = false;
  bool notifications =  true;

}