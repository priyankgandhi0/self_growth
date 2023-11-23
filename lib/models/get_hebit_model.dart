class GetHabitModel {
  List<HabitData>? data;
  String? msg;
  bool? status;

  GetHabitModel({this.data, this.msg, this.status});

  GetHabitModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HabitData>[];
      json['data'].forEach((v) {
        data!.add(HabitData.fromJson(v));
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

class HabitData {
  int? habitId;
  String? userToken;
  String? habitName;
  String? icon;
  String? iconColor;
  int? goalTimes;
  String? goalResetTime;
  int? isReminderOn;
  String? reminderTime;
  String? reminderUtcTime;
  String? reminderNote;
  String? groupName;
  String? habitType;
  int? logActivityUsing;
  int? showBadge;
  int? showGoal;
  String? note;
  String? habitCreatedDate;
  int? streak;

  HabitData(
      {this.habitId,
      this.userToken,
      this.habitName,
      this.icon,
      this.iconColor,
      this.goalTimes,
      this.goalResetTime,
      this.isReminderOn,
      this.reminderTime,
      this.reminderUtcTime,
      this.reminderNote,
      this.groupName,
      this.habitType,
      this.logActivityUsing,
      this.showBadge,
      this.showGoal,
      this.note,
      this.habitCreatedDate,
      this.streak});

  HabitData.fromJson(Map<String, dynamic> json) {
    habitId = json['habit_id'];
    userToken = json['user_token'];
    habitName = json['habit_name'];
    icon = json['icon'];
    iconColor = json['icon_color'];
    goalTimes = json['goal_times'];
    goalResetTime = json['goal_reset_time'];
    isReminderOn = json['is_reminder_on'];
    reminderTime = json['reminder_time'];
    reminderUtcTime = json['reminder_utc_time'];
    reminderNote = json['reminder_note'];
    groupName = json['group_name'];
    habitType = json['habit_type'];
    logActivityUsing = json['log_activity_using'];
    showBadge = json['show_badge'];
    showGoal = json['show_goal'];
    note = json['note'];
    habitCreatedDate = json['habit_created_date'];
    streak = json['streak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['habit_id'] = habitId;
    data['user_token'] = userToken;
    data['habit_name'] = habitName;
    data['icon'] = icon;
    data['icon_color'] = iconColor;
    data['goal_times'] = goalTimes;
    data['goal_reset_time'] = goalResetTime;
    data['is_reminder_on'] = isReminderOn;
    data['reminder_time'] = reminderTime;
    data['reminder_utc_time'] = reminderUtcTime;
    data['reminder_note'] = reminderNote;
    data['group_name'] = groupName;
    data['habit_type'] = habitType;
    data['log_activity_using'] = logActivityUsing;
    data['show_badge'] = showBadge;
    data['show_goal'] = showGoal;
    data['note'] = note;
    data['habit_created_date'] = habitCreatedDate;
    data['streak'] = streak;
    return data;
  }
}
