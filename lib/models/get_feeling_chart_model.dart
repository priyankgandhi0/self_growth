class GetFeelingChartModel {
  List<ChartData>? data;
  String? msg;
  bool? status;

  GetFeelingChartModel({this.data, this.msg, this.status});

  GetFeelingChartModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChartData>[];
      json['data'].forEach((v) {
        data!.add(ChartData.fromJson(v));
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

class ChartData {
  String? date;
  List<Chart>? chart;

  ChartData({this.date, this.chart});

  ChartData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['chart'] != null) {
      chart = <Chart>[];
      json['chart'].forEach((v) {
        chart!.add(Chart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (chart != null) {
      data['chart'] = chart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chart {
  int? id;
  String? userToken;
  String? icon;
  String? name;
  String? createdDate;
  String? updatedDate;
  String? postDate;

  Chart(
      {this.id,
      this.userToken,
      this.icon,
      this.name,
      this.createdDate,
      this.updatedDate,
      this.postDate});

  Chart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userToken = json['user_token'];
    icon = json['icon'];
    name = json['name'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    postDate = json['post_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_token'] = userToken;
    data['icon'] = icon;
    data['name'] = name;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['post_date'] = postDate;
    return data;
  }
}
