import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants_colors.dart';

ThemeData themeData = ThemeData(
    primaryColor: kprimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      border: outlineInputBorder,
      errorBorder: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: kprimaryColor,
    )));

OutlineInputBorder outlineInputBorder =
    const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
