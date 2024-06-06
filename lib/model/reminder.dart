import 'package:fastlink_reminder/model/schedules.dart';

class Reminder {
  String? title;
  int? userId;
  String? description;
  String? triggerAt;
  List<Schedules>? schedules;

  Reminder(
      {this.title,
      this.userId,
      this.description,
      this.triggerAt,
      this.schedules});

  Reminder.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    userId = json['user_id'];
    description = json['description'];
    triggerAt = json['trigger_at'];
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        schedules!.add(Schedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['user_id'] = userId;
    data['description'] = description;
    data['trigger_at'] = triggerAt;
    if (schedules != null) {
      data['schedules'] = schedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
