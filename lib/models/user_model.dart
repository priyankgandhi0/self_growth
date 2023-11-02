
import 'dart:convert';

class UserModel {
  final UserData data;
  final String msg;
  final bool status;

  UserModel({
    required this.data,
    required this.msg,
    required this.status,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: UserData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "msg": msg,
    "status": status,
  };
}

class UserData {
  final int userId;
  final String userToken;
  final String email;
  final String userName;
  final String userProfilePhoto;
  final int age;
  final String gender;
  final String loginType;
  final String phoneNumber;
  final String authToken;
  final String devicePushToken;
  final String deviceType;
  final String verifyEmailCode;
  final String verifyForgotCode;
  final int isLoggedOut;

  UserData({
    required this.userId,
    required this.userToken,
    required this.email,
    required this.userName,
    required this.userProfilePhoto,
    required this.age,
    required this.gender,
    required this.loginType,
    required this.phoneNumber,
    required this.authToken,
    required this.devicePushToken,
    required this.deviceType,
    required this.verifyEmailCode,
    required this.verifyForgotCode,
    required this.isLoggedOut,
  });

  factory UserData.fromRawJson(String str) => UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    userId: json["user_id"],
    userToken: json["user_token"],
    email: json["email"],
    userName: json["user_name"],
    userProfilePhoto: json["user_profile_photo"],
    age: json["age"],
    gender: json["gender"],
    loginType: json["login_type"],
    phoneNumber: json["phone_number"],
    authToken: json["auth_token"],
    devicePushToken: json["device_push_token"],
    deviceType: json["device_type"],
    verifyEmailCode: json["verify_email_code"],
    verifyForgotCode: json["verify_forgot_code"],
    isLoggedOut: json["is_logged_out"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_token": userToken,
    "email": email,
    "user_name": userName,
    "user_profile_photo": userProfilePhoto,
    "age": age,
    "gender": gender,
    "login_type": loginType,
    "phone_number": phoneNumber,
    "auth_token": authToken,
    "device_push_token": devicePushToken,
    "device_type": deviceType,
    "verify_email_code": verifyEmailCode,
    "verify_forgot_code": verifyForgotCode,
    "is_logged_out": isLoggedOut,
  };
}
