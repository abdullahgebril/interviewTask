import 'package:flutter/material.dart';
import 'package:newtask/core/app/app.dart';
import 'package:newtask/core/network/api_manager.dart';
import 'package:newtask/core/util/cache_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreference.init();
  ApiManager.init();

  runApp(const MainApp());
}
