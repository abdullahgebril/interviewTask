import 'package:newtask/core/network/api_manager.dart';
import 'package:newtask/domain/home/data/model/marker_model.dart';

class HomeApi {
  static Future<MarkerModel> getMarkers() async {
    final response = await ApiManager.sendRequest(
        link: 'getMarkers.php', method: Method.POST);
    return MarkerModel.fromJson(response!.data!);
  }
}
