/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static final TextStyle _textStyle = GoogleFonts.outfit();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bgColor,
    hintColor: hintColor,
    shadowColor: Colors.black.withOpacity(0.08),
    textTheme: TextTheme(
      bodyLarge: _textStyle.copyWith(
        color: primaryColor,
        fontSize: 16,
      ),
      bodyMedium: _textStyle.copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      bodySmall: _textStyle.copyWith(
        color: primaryColor,
      ),
      labelLarge: _textStyle.copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      labelMedium: _textStyle.copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      labelSmall: _textStyle.copyWith(
        color: primaryColor,
        fontSize: 16,
      ),
      headlineLarge: _textStyle.copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 34,
      ),
      headlineMedium: _textStyle.copyWith(
        color: primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
      headlineSmall: _textStyle.copyWith(
        color: headLineSmallColor,
        fontSize: 16,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: null,
      focusColor: primaryColor,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: textFieldBorderColor,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: textFieldBorderColor,
        ),
      ),
      labelStyle: _textStyle.copyWith(
        color: hintColor,
        fontSize: 16,
      ),
      hintStyle: _textStyle.copyWith(
        color: hintColor,
        fontSize: 16,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        minimumSize: const Size(88, 36),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: _textStyle.copyWith(
        color: redColor,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
      visualDensity: VisualDensity.compact,
    ),
    dialogBackgroundColor: bgColor,
    colorScheme: const ColorScheme.light(
      background: bgColor,
      primary: primaryColor,
      surfaceVariant: Colors.transparent,
    ),
  );
}

**/
