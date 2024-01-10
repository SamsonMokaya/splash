import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Poppins',
      textTheme: textTheme(),
      primarySwatch: Colors.amber,
      appBarTheme: const AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle:
              TextStyle(color: Colors.white, fontFamily: 'Ariata')));
}

TextTheme textTheme() {
  return const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
  );
}
