import 'package:flutter/material.dart';
import 'package:newtask/core/api/auth_api/auth_api.dart';
import 'package:newtask/core/exception/api_exception.dart';
import 'package:newtask/core/util/cache_manager.dart';
import 'package:newtask/core/widget/flutter_toast.dart';
import 'package:newtask/domain/home/view/screen/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  Future<void> login(BuildContext context,
      {required String phoneNumber, required String password}) async {
    _setLoading(true);
    try {
      final userResponse = await AuthApi.login(phoneNumber, password);
      _setLoading(false);
      showFlutterToast(msg: userResponse.message);

      UserPreference.saveUserToken(userResponse.data.userToken);
      if (context.mounted) {
        navigateToHomeScreen(context);
      }
    } on ApiException catch (e) {
      // show toast with error message
      showFlutterToast(msg: e.error);
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => const HomeScreen()), (_) => false);
   
  }
}
