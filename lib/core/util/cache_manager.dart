
import 'package:shared_preferences/shared_preferences.dart';
class UserPreference {
  static SharedPreferences? sharedPreferences;
  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  


  static dynamic getUserToken() =>
      sharedPreferences!.getString("userToken");
 static void saveUserToken(String userToken){
  sharedPreferences!.setString("userToken", userToken);
 }
  

  static isContainUserToken() {
    return sharedPreferences!.containsKey("userToken");
  }
}
