import 'package:flutter/material.dart';

import '../../core/color_pallette/app_pallette.dart';

class AppTheme {
  // light theme

  static TextStyle lightBodyTextStyle(
          {Color? color, double? size, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Poppins',
          color: color ?? AppPellete.textBlackColor,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: size ?? 16,
          decoration: TextDecoration.none);

  static _border({Color color = AppPellete.borderColor}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: color, width: 2));

  static const TextStyle lightTitleTextStyle = TextStyle(
      fontFamily: 'Poppins',
      color: AppPellete.textBlackColor,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      decoration: TextDecoration.none);

  static TextTheme lightTextTheme = TextTheme(
      titleMedium: lightTitleTextStyle, bodyMedium: lightBodyTextStyle());

  static final ElevatedButtonThemeData lightButtonThemeData =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppPellete.themeColor,
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))));

  static BottomNavigationBarThemeData lightBottomBarTheme =
      BottomNavigationBarThemeData(
    selectedLabelStyle: lightBodyTextStyle(
        color: AppPellete.themeColor, size: 13, fontWeight: FontWeight.w500),
    type: BottomNavigationBarType.fixed,
    selectedIconTheme:
         IconThemeData(size: 22, color: AppPellete.themeColor),
    unselectedIconTheme:
        const IconThemeData(size: 22, color: AppPellete.textBlackColor),
    unselectedLabelStyle: lightBodyTextStyle(
        color: AppPellete.textBlackColor,
        size: 13,
        fontWeight: FontWeight.w500),
  );

  static TabBarTheme lightTabTheme = TabBarTheme(
      indicatorColor: AppPellete.themeColor,
      labelColor: AppPellete.themeColor,
      unselectedLabelColor: AppPellete.textBlackColor,
      labelStyle: lightBodyTextStyle(
          color: AppPellete.themeColor, fontWeight: FontWeight.w500),
      unselectedLabelStyle: lightBodyTextStyle(
          color: AppPellete.textBlackColor, fontWeight: FontWeight.w500));

  static final InputDecorationTheme lightInputDecoration = InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: _border(),
      errorBorder: _border(color: AppPellete.errorColor),
      focusedErrorBorder: _border(color: AppPellete.errorColor),
    errorStyle: lightBodyTextStyle(
        fontWeight: FontWeight.w300,
        size: 14,
        color: AppPellete.errorColor),
    hintStyle: lightBodyTextStyle(
        fontWeight: FontWeight.w300,
        size: 14,
        color: AppPellete.borderColor),
      focusedBorder: _border(
        color: AppPellete.themeColor,
      ));

  static dynamic lightTheme = ThemeData.light(useMaterial3: true).copyWith(
      textTheme: lightTextTheme,
      bottomNavigationBarTheme: lightBottomBarTheme,
      appBarTheme: const AppBarTheme().copyWith(
        titleTextStyle: lightTitleTextStyle,
      ),
      tabBarTheme: lightTabTheme,
      inputDecorationTheme: lightInputDecoration,
      elevatedButtonTheme: lightButtonThemeData);
  // --------------------------------------------------------------------------------------------------//

  // dark theme
  static TextStyle darkBodyTextStyle(
          {Color? color, double? size, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Poppins',
          color: color ?? AppPellete.textWhiteColor,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: size ?? 16,
          decoration: TextDecoration.none);

  static const TextStyle darkTitleTextStyle = TextStyle(
      fontFamily: 'Poppins',
      color: AppPellete.textWhiteColor,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      decoration: TextDecoration.none);

  static TextTheme darkTextTheme = TextTheme(
      titleMedium: darkTitleTextStyle, bodyMedium: darkBodyTextStyle());

  static final ElevatedButtonThemeData darkButtonThemeData =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppPellete.themeColor,
              fixedSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))));

  static final InputDecorationTheme darkInputDecoration = InputDecorationTheme(
      fillColor: AppPellete.darkFillColor,
      filled: true,
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: _border(color: AppPellete.darkFillColor),
      errorBorder: _border(color: AppPellete.errorColor),
      errorStyle: darkBodyTextStyle(
          fontWeight: FontWeight.w300,
          size: 14,
          color: AppPellete.errorColor),
      hintStyle: darkBodyTextStyle(
          fontWeight: FontWeight.w300,
          size: 14,
          color: AppPellete.borderColor),
      focusedErrorBorder: _border(color: AppPellete.errorColor),
      focusedBorder: _border(color: AppPellete.themeColor));

  static BottomNavigationBarThemeData darkBottomBarTheme =
      BottomNavigationBarThemeData(
    selectedLabelStyle: darkBodyTextStyle(
        color: AppPellete.themeColor, size: 13, fontWeight: FontWeight.w500),
    type: BottomNavigationBarType.fixed,
    selectedIconTheme:
         IconThemeData(size: 22, color: AppPellete.themeColor),
    unselectedIconTheme:
        const IconThemeData(size: 22, color: AppPellete.textWhiteColor),
    unselectedLabelStyle: darkBodyTextStyle(
        color: AppPellete.textWhiteColor,
        size: 13,
        fontWeight: FontWeight.w500),
  );

  static TabBarTheme darkTabTheme = TabBarTheme(
      indicatorColor: AppPellete.themeColor,
      labelColor: AppPellete.themeColor,
      unselectedLabelColor: AppPellete.textWhiteColor,
      labelStyle: darkBodyTextStyle(
          color: AppPellete.themeColor, fontWeight: FontWeight.w500),
      unselectedLabelStyle: darkBodyTextStyle(
          color: AppPellete.textWhiteColor, fontWeight: FontWeight.w500));

  static dynamic darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
      textTheme: darkTextTheme,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppPellete.themeColor,
         foregroundColor: AppPellete.textWhiteColor
      ),
      bottomNavigationBarTheme: darkBottomBarTheme,
      appBarTheme: const AppBarTheme().copyWith(
        titleTextStyle: darkTitleTextStyle,
      ),
      tabBarTheme: darkTabTheme,
      inputDecorationTheme: darkInputDecoration,
      elevatedButtonTheme: darkButtonThemeData);
}
