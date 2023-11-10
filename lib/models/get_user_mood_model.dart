class GetUserMoodModel {
  List<MoodData>? data;
  String? msg;
  bool? status;

  GetUserMoodModel({this.data, this.msg, this.status});

  GetUserMoodModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MoodData>[];
      json['data'].forEach((v) {
        data!.add(MoodData.fromJson(v));
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

class MoodData {
  int? umId;
  String? userToken;
  String? type;
  String? moodPhoto;
  String? feeling;
  String? unhappyReason;
  String? howAreYouFeeling;
  String? title;
  String? noteTime;
  String? moodDate;
  String? note;
  List<UnhappyReasonFeeling>? unhappyReasonFeeling;

  MoodData(
      {this.umId,
      this.userToken,
      this.type,
      this.moodPhoto,
      this.feeling,
      this.unhappyReason,
      this.howAreYouFeeling,
      this.title,
      this.noteTime,
      this.moodDate,
      this.note,
      this.unhappyReasonFeeling});

  MoodData.fromJson(Map<String, dynamic> json) {
    umId = json['um_id'];
    userToken = json['user_token'];
    type = json['type'];
    moodPhoto = json['mood_photo'];
    feeling = json['feeling'];
    unhappyReason = json['unhappy_reason'];
    howAreYouFeeling = json['how_are_you_feeling'];
    title = json['title'];
    noteTime = json['note_time'];
    moodDate = json['mood_date'];
    note = json['note'];
    if (json['unhappy_reason_feeling'] != null) {
      unhappyReasonFeeling = <UnhappyReasonFeeling>[];
      json['unhappy_reason_feeling'].forEach((v) {
        unhappyReasonFeeling!.add(UnhappyReasonFeeling.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['um_id'] = umId;
    data['user_token'] = userToken;
    data['type'] = type;
    data['mood_photo'] = moodPhoto;
    data['feeling'] = feeling;
    data['unhappy_reason'] = unhappyReason;
    data['how_are_you_feeling'] = howAreYouFeeling;
    data['title'] = title;
    data['note_time'] = noteTime;
    data['mood_date'] = moodDate;
    data['note'] = note;
    if (unhappyReasonFeeling != null) {
      data['unhappy_reason_feeling'] =
          unhappyReasonFeeling!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnhappyReasonFeeling {
  int? id;
  String? userToken;
  String? icon;
  String? name;

  UnhappyReasonFeeling({this.id, this.userToken, this.icon, this.name});

  UnhappyReasonFeeling.fromJson(Map<String, dynamic> json) {
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