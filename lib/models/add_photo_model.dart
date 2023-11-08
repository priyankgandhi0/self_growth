class AddPhotoModel {
  PhotoData? data;
  String? msg;
  bool? status;

  AddPhotoModel({this.data, this.msg, this.status});

  AddPhotoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? PhotoData.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class PhotoData {
  int? umId;
  String? userToken;
  String? type;
  String? moodPhoto;
  String? feeling;
  String? unhappyReason;
  String? howAreYouFeeling;
  String? noteTime;
  String? note;

  PhotoData(
      {this.umId,
      this.userToken,
      this.type,
      this.moodPhoto,
      this.feeling,
      this.unhappyReason,
      this.howAreYouFeeling,
      this.noteTime,
      this.note});

  PhotoData.fromJson(Map<String, dynamic> json) {
    umId = json['um_id'];
    userToken = json['user_token'];
    type = json['type'];
    moodPhoto = json['mood_photo'];
    feeling = json['feeling'];
    unhappyReason = json['unhappy_reason'];
    howAreYouFeeling = json['how_are_you_feeling'];
    noteTime = json['note_time'];
    note = json['note'];
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
    data['note_time'] = noteTime;
    data['note'] = note;
    return data;
  }
}
