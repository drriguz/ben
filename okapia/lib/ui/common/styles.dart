import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTextTheme = TextTheme(
  headline1: GoogleFonts.ubuntu(
      fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.ubuntu(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.ubuntu(fontSize: 49, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.ubuntu(
      fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.ubuntu(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.ubuntu(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.ubuntu(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.ubuntu(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.ubuntu(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.ubuntu(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.ubuntu(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.ubuntu(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.ubuntu(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

final globalTheme = ThemeData(
  primarySwatch: Colors.indigo,
  textTheme: appTextTheme,
);

class Styles {
  static const TextStyle descriptionStyle = TextStyle(
    color: Colors.grey,
    fontSize: 14,
  );
}
