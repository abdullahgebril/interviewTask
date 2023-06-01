import 'package:dio/dio.dart';
import 'package:newtask/core/network/api_manager.dart';
import 'package:newtask/core/network/request_body.dart';
import 'package:newtask/domain/login/data/model/user_model.dart';

class AuthApi {
  static Future<User> login(String phoneNumber, String password) async {
    RequestBody requestBody = RequestBody({
      "UserPhone": phoneNumber,
      "Password": password,
      "UserFirebaseToken": "sjhgjsdhgjshdfgjksdfsjkg"
    });
    final response = await ApiManager.sendRequest(
        link: 'LoginUser.php',
        body: requestBody,
        formData: FormData.fromMap(requestBody.body),
        method: Method.POST);
    return User.fromJson(response!.data!);
  }
}
