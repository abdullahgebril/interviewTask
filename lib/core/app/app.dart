import 'package:flutter/material.dart';
import 'package:newtask/core/util/theme_manager.dart';
import 'package:newtask/domain/login/view/screen/login.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,theme: getApplicationTheme(), home: const LoginScreen());
  }
}
