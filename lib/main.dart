import 'package:flutter/material.dart';
import 'package:newtask/core/app/app.dart';
import 'package:newtask/core/network/api_manager.dart';
import 'package:newtask/core/util/cache_manager.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
  );
  await UserPreference.init();
  await UserPreference.init();
  ApiManager.init();

  runApp(const MainApp());
}
