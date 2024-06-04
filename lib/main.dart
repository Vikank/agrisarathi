import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/initial/splash_screen.dart';
import 'package:fpo_assist/screens/shared/auth/login_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: _configureThemeData(),
        home: SplashScreen());
  }

  ThemeData _configureThemeData() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            fontSize: 20.0,
            color: Color(0xff262626),
            fontWeight: FontWeight.w500),
        labelLarge: TextStyle(
            fontSize: 20.0,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500),
        labelMedium: TextStyle(
            fontSize: 14.0,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500),
        displaySmall: TextStyle(
            fontSize: 12.0,
            color: Color(0xff808080),
            fontWeight: FontWeight.w400),
        displayMedium: TextStyle(
            fontSize: 12.0,
            color: Color(0xff808080),
            fontWeight: FontWeight.w500),
        headlineMedium: TextStyle(
            fontSize: 10.0,
            color: Color(0xff808080),
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
