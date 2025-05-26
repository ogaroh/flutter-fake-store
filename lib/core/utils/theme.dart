import 'package:flutter/material.dart';
import 'package:fake_store/core/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.white,
    textTheme: GoogleFonts.urbanistTextTheme().apply(
      bodyColor: AppColors.black,
      displayColor: AppColors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      iconTheme: IconThemeData(color: AppColors.black),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryDark,
      secondary: AppColors.primaryDark,
      surface: AppColors.white,
      onPrimary: AppColors.black,
      onSecondary: AppColors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: AppColors.dark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.outline, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.outline, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.grey, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      fillColor: AppColors.greyFill,
      filled: true,
      hintStyle: TextStyle(
        color: AppColors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    primaryColor: AppColors.dark,
    scaffoldBackgroundColor: AppColors.dark,
    textTheme: GoogleFonts.urbanistTextTheme().apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.dark,
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: AppColors.primaryDark,
      secondary: AppColors.primaryDark,
      surface: AppColors.dark,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
    ),
  );
}
