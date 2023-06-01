import 'package:flutter/material.dart';



class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontManager {
  static TextStyle _getTextStyle(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color);
  }

  static TextStyle getRegularStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

  static TextStyle getLightStyle({double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }

  static TextStyle getMediumStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

  static TextStyle getSemiBoldStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }

  static TextStyle getBoldStyle({double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.bold, color);
  }
}
