import 'package:flutter/material.dart';
import 'package:fpo_assist/screens/initial/splash_screen.dart';
import 'package:fpo_assist/utils/messages_translation.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: MessagesTranslation(),
      locale: Locale('hi', 'IN'),
      fallbackLocale: Locale('hi', 'IN'),
      debugShowCheckedModeBanner: false,
        title: 'AgriSarthi',
        theme: _configureThemeData(),
        home: SplashScreen());
  }

  ThemeData _configureThemeData() {
    return ThemeData(
      useMaterial3: true,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
            fontSize: 20.0,
            color: Color(0xff262626),
            fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
            fontSize: 20.0,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500),
        labelMedium: TextStyle(
            fontSize: 15.0,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
        ),
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
