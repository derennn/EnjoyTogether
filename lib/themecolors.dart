import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor appSwatch = MaterialColor(
    0xff242b38,
    <int, Color>{
      50: Color(0xff202732),//10%
      100: Color(0xff1d222d),//20%
      200: Color(0xff191e27),//30%
      300: Color(0xff161a22),//40%
      400: Color(0xff12161c),//50%
      500: Color(0xff0e1116),//60%
      600: Color(0xff0b0d11),//70%
      700: Color(0xff07090b),//80%
      800: Color(0xff040406),//90%
      900: Color(0xff000000),//100%
    },
  );
  static const MaterialColor neonGreenShades = MaterialColor(
    0xff1be2c7,
    <int, Color>{
      50: Color(0xff18cbb3),
      100: Color(0xff16b59f),
      200: Color(0xff139e8b),
      300: Color(0xff108877),
      400: Color(0xff0e7164),
      500: Color(0xff0b5a50),
      600: Color(0xff08443c),
      700: Color(0xff052d28),
      800: Color(0xff031714),
      900: Color(0xff000000),
    }
  );
}

Color primaryDarkBlue = const Color(0xff242b38);
Color neonGreen = const Color(0xff1be2c7);