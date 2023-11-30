class QuestionModel {
  List<QuestionData>? data;
  String? msg;
  int? status;

  QuestionModel({this.data, this.msg, this.status});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <QuestionData>[];
      json['data'].forEach((v) {
        data!.add(QuestionData.fromJson(v));
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

class QuestionData {
  int? questionsId;
  String? questionsTitle;
  String? questionsDesc;

  QuestionData({this.questionsId, this.questionsTitle, this.questionsDesc});

  QuestionData.fromJson(Map<String, dynamic> json) {
    questionsId = json['questions_id'];
    questionsTitle = json['questions_title'];
    questionsDesc = json['questions_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questions_id'] = questionsId;
    data['questions_title'] = questionsTitle;
    data['questions_desc'] = questionsDesc;
    return data;
  }
}
