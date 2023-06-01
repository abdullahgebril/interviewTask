import 'dart:convert';

MarkerModel markerFromJson(String str) => MarkerModel.fromJson(json.decode(str));

String markerToJson(MarkerModel data) => json.encode(data.toJson());

class MarkerModel {
    int statusCode;
    bool success;
    List<MarkerData> data;
    String message;

    MarkerModel({
        required this.statusCode,
        required this.success,
        required this.data,
        required this.message,
    });

    factory MarkerModel.fromJson(Map<String, dynamic> json) => MarkerModel(
        statusCode: json["status_code"],
        success: json["success"],
        data: List<MarkerData>.from(json["data"].map((x) => MarkerData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class MarkerData {
    String taskId;
    String lat;
    String longt;
    String name;

    MarkerData({
        required this.taskId,
        required this.lat,
        required this.longt,
        required this.name,
    });

    factory MarkerData.fromJson(Map<String, dynamic> json) => MarkerData(
        taskId: json["TaskID"],
        lat: json["Lat"],
        longt: json["Longt"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "TaskID": taskId,
        "Lat": lat,
        "Longt": longt,
        "Name": name,
    };
}
