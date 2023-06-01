import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'font_manager.dart';


ThemeData getApplicationTheme() {
  return ThemeData(
    // main Color
    primaryColor: Colors.blue,

//appBar theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.white,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
          // Navigation bar
          systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark // Status bar
          ),
    ),
    // text theme
    textTheme: TextTheme(
      titleMedium: FontManager.getSemiBoldStyle(
          fontSize: 20, color: Colors.blue,),
   
    ),

    //elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        textStyle: FontManager.getSemiBoldStyle(
            fontSize: 16, color: Colors.white),
        backgroundColor: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      filled: true,
      fillColor: Colors.white,
      hintStyle: FontManager.getRegularStyle(
          fontSize: 14, color: Colors.grey),
      errorStyle: FontManager.getRegularStyle(color: Colors.red),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
       
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1, color: Colors.blue[600]!)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color:Colors.red, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
