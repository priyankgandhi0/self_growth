import 'dart:convert';

ResponseItem responseItemFromJson(String str) =>
    ResponseItem.fromJson(json.decode(str));

String responseItemToJson(ResponseItem data) => json.encode(data.toJson());

class ResponseItem {
  ResponseItem({
    this.data,
    required this.message,
    required this.status,
    this.forceLogout,
  });

  dynamic data;
  String message;
  bool status;
  bool? forceLogout = false;

  factory ResponseItem.fromJson(Map<String, dynamic> json) => ResponseItem(
    data: json["data"],
    message: json["msg"],
    status: json["status"] == 1,
    forceLogout: json["force_logout"] == 1,
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "msg": message,
    "status": status,
    "force_logout": forceLogout,
  };
}