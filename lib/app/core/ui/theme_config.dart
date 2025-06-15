import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData tema = ThemeData();

  ThemeConfig._();

  static ThemeData get theme => ThemeData(
    canvasColor: const Color.fromRGBO(240, 240, 240, 1),

    textTheme: GoogleFonts.mandaliTextTheme(),

    colorScheme: tema.colorScheme.copyWith(
      primary: const Color.fromRGBO(138, 5, 190, 1),
      secondary: const Color.fromRGBO(83, 0, 130, 1),
    ),

    iconTheme: const IconThemeData(size: 24),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF5C77CE),
      ),
    ),

    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}
