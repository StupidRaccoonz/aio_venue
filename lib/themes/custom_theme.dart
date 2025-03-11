import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scaled_size/scaled_size.dart';

class CustomTheme {
  static Color appColor = const Color(0xFF15192C);
  static Color appColorSecondary = const Color(0xFFFF6B21);
  static Color appColorSecondaryLight = const Color(0xFFFFF8F4);
  // static Color textColor = const Color(0xff15192c);
  static Color textColor = const Color(0xFF15192C);
  static Color textColor2 = const Color(0xFF303345);
  static Color textColorLight = const Color(0xffA1ADB2);
  static Color iconColor = const Color(0xff5640FB);
  // static Color blue = const Color(0xff5640FB);f7f9fa background: #5640FB;
  static Color bocLightBackground = const Color(0xffF7F9FA);
  static Color borderColor = const Color(0xffedecef);
  static Color cherryRed = const Color(0xffC51B1B);
  static Color green = const Color(0xFF25A70F);
  static Color grey = const Color(0xFF9FA1A6);
  static Color lineGrey = const Color(0xFFE9E8EB);
  static Color cyan = const Color(0xFF20B9FC);

  static TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 23.rfs, fontWeight: FontWeight.w500, color: appColor, letterSpacing: 1.5, fontFamily: 'Inter'),
    // only for input style
    titleMedium: TextStyle(fontSize: 15.rfs, fontWeight: FontWeight.w400, color: appColor, letterSpacing: 1.5, fontFamily: 'Inter'),
    displayLarge: TextStyle(fontSize: 23.rfs, fontWeight: FontWeight.bold, color: appColor, letterSpacing: 1.0, fontFamily: 'Inter'),
    displayMedium: TextStyle(fontSize: 18.rfs, color: appColor, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
    displaySmall: TextStyle(fontSize: 12.rfs, color: textColorLight, letterSpacing: 0.8, fontFamily: 'Inter'),
    bodyLarge: TextStyle(fontSize: 18.rfs, color: appColor, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
    bodyMedium: TextStyle(fontSize: 16.rfs, color: appColor, fontWeight: FontWeight.w300, fontFamily: 'Inter'),
    bodySmall: TextStyle(fontSize: 12.rfs, color: appColor, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
    titleSmall: TextStyle(fontSize: 16.rfs, color: appColor, fontFamily: 'Inter'),
    labelSmall: TextStyle(fontSize: 13.rfs, color: textColorLight, letterSpacing: 0.7, fontFamily: 'Inter'),
    labelLarge: TextStyle(fontSize: 16.rfs, color: textColorLight, fontFamily: 'Inter'),
    labelMedium: TextStyle(fontSize: 14.rfs, color: appColor, fontWeight: FontWeight.w300, fontFamily: 'Inter'),
    headlineSmall: TextStyle(fontSize: 12.rfs, color: iconColor, fontWeight: FontWeight.w500, fontFamily: 'Inter'), //for links only
    headlineMedium: TextStyle(fontSize: 14.rfs, color: textColorLight, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
    headlineLarge: TextStyle(fontSize: 14.rfs, color: appColor, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
  );
  static AppBarTheme appBarTheme = AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20.rfs, color: Colors.white, fontWeight: FontWeight.w400, letterSpacing: 1.2, fontFamily: 'Inter'),
    iconTheme: IconThemeData(color: Colors.white, size: 20.rh),
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light, // 2
  );

  static BoxDecoration backgroundDecoration = const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icons/logo.png')));
}
