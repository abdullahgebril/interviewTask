
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    int statusCode;
    bool success;
    Data data;
    String message;

    User({
        required this.statusCode,
        required this.success,
        required this.data,
        required this.message,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        statusCode: json["status_code"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "success": success,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    String usersId;
    String userName;
    String userPhone;
    String password;
    String email;
    String userToken;
    String userFirebaseToken;
    String loginType;
    String socialid;
    String userPhoto;
    String userStatus;
    DateTime lastUpdatedUsers;
    DateTime createdAtUser;
    String userRate;
    String userTimesOfRates;
    String userTotalRates;
    String tripNumber;
    String hasTrip;
    String login;
    String userVersion;

    Data({
        required this.usersId,
        required this.userName,
        required this.userPhone,
        required this.password,
        required this.email,
        required this.userToken,
        required this.userFirebaseToken,
        required this.loginType,
        required this.socialid,
        required this.userPhoto,
        required this.userStatus,
        required this.lastUpdatedUsers,
        required this.createdAtUser,
        required this.userRate,
        required this.userTimesOfRates,
        required this.userTotalRates,
        required this.tripNumber,
        required this.hasTrip,
        required this.login,
        required this.userVersion,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        usersId: json["UsersID"],
        userName: json["UserName"],
        userPhone: json["UserPhone"],
        password: json["Password"],
        email: json["Email"],
        userToken: json["UserToken"],
        userFirebaseToken: json["UserFirebaseToken"],
        loginType: json["LoginType"],
        socialid: json["Socialid"],
        userPhoto: json["UserPhoto"],
        userStatus: json["UserStatus"],
        lastUpdatedUsers: DateTime.parse(json["lastUpdatedUsers"]),
        createdAtUser: DateTime.parse(json["CreatedAtUser"]),
        userRate: json["UserRate"],
        userTimesOfRates: json["UserTimesOfRates"],
        userTotalRates: json["UserTotalRates"],
        tripNumber: json["TripNumber"],
        hasTrip: json["HasTrip"],
        login: json["Login"],
        userVersion: json["UserVersion"],
    );

    Map<String, dynamic> toJson() => {
        "UsersID": usersId,
        "UserName": userName,
        "UserPhone": userPhone,
        "Password": password,
        "Email": email,
        "UserToken": userToken,
        "UserFirebaseToken": userFirebaseToken,
        "LoginType": loginType,
        "Socialid": socialid,
        "UserPhoto": userPhoto,
        "UserStatus": userStatus,
        "lastUpdatedUsers": lastUpdatedUsers.toIso8601String(),
        "CreatedAtUser": createdAtUser.toIso8601String(),
        "UserRate": userRate,
        "UserTimesOfRates": userTimesOfRates,
        "UserTotalRates": userTotalRates,
        "TripNumber": tripNumber,
        "HasTrip": hasTrip,
        "Login": login,
        "UserVersion": userVersion,
    };
}
