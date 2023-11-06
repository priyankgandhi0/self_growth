class GetActivityModel {
  List<ActivityData>? data;
  String? msg;
  int? status;

  GetActivityModel({this.data, this.msg, this.status});

  GetActivityModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ActivityData>[];
      json['data'].forEach((v) {
        data!.add(ActivityData.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class ActivityData {
  int? id;
  String? userToken;
  String? icon;
  String? name;

  ActivityData({this.id, this.userToken, this.icon, this.name});

  ActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userToken = json['user_token'];
    icon = json['icon'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_token'] = userToken;
    data['icon'] = icon;
    data['name'] = name;
    return data;
  }
}
