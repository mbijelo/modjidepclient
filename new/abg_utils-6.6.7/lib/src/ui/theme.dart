import 'package:flutter/material.dart';

var colorCardGrey = Color(0xfff3f6f9);
var colorCardGreenGrey = Color(0xffddf1f3);
var colorCardDark = Color(0xff303030);

abstract class DefaultTheme {
  double radius = 0;
  bool darkMode = false;
  Color mainColor = Colors.green;
  Color blackColorTitleBkg = Colors.black;

  late TextStyle style10W400;
  late TextStyle style10W400White;
  late TextStyle style10W800White;
  late TextStyle style11W800W;
  late TextStyle style11W600;
  late TextStyle style12W600White;
  late TextStyle style12W600Orange;
  late TextStyle style12W600Grey;
  late TextStyle style12W400;
  late TextStyle style12W400D;
  late TextStyle style12W800W;
  late TextStyle style12W800;
  late TextStyle style12W800MainColor;
  late TextStyle style13W400;
  late TextStyle style13W800;
  late TextStyle style13W800Red;
  late TextStyle style13W800Blue;
  late TextStyle style14W600White;
  late TextStyle style14W400;
  late TextStyle style14W400Grey;
  late TextStyle style14W800;
  late TextStyle style14W800MainColor;
  late TextStyle style16W800White;
  late TextStyle style16W800;
  late TextStyle style16W800Orange;
  late TextStyle style16W800Green;

}

late DefaultTheme aTheme;

//
//
// class DefaultThemeImpl implements DefaultTheme {
//
//   @override
//   Color getBackColor(){
//     return Colors.white;
//   }
//
//   @override
//   double radius = 0;
//
//   @override
//   String getFontName(){
//     return "";
//   }
// }
//
// class UtilTheme{
//
//   String font = "";
//   late Color backColor;
//   late double radius;
//
//   late TextStyle style14W400;
//
//   UtilTheme(){
//     font = defTheme.getFontName();
//     backColor = defTheme.getBackColor();
//     radius = defTheme.radius;
//
//     style14W400 = TextStyle(fontFamily: font, letterSpacing: 0.6,
//         fontSize: 14, fontWeight: FontWeight.w400, color: backColor);
//   }
// }
//
// DefaultTheme defTheme = DefaultThemeImpl();
// // UtilTheme theme = UtilTheme();
//
//
