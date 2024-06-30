import 'package:equatable/equatable.dart';
import 'package:fastlink_reminder/model/schedules.dart';

// ignore: must_be_immutable
class Reminder extends Equatable {
  Reminder({
    required this.title,
    required this.description,
    required this.triggerAt,
    required this.schedules,
    required this.reminderId,
    required this.isRepeatingAnnually,
  });

  String title;
  String description;
  int reminderId;
  DateTime? triggerAt;
  bool isRepeatingAnnually;
  List<Schedule> schedules;

  Reminder copyWith({
    String? title,
    String? description,
    DateTime? triggerAt,
    int? reminderId,
    List<Schedule>? schedules,
  }) {
    return Reminder(
      title: title ?? this.title,
      description: description ?? this.description,
      triggerAt: triggerAt ?? this.triggerAt,
      reminderId: reminderId ?? this.reminderId,
      isRepeatingAnnually: isRepeatingAnnually,
      schedules: schedules ?? this.schedules,
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    print(json);
    return Reminder(
      reminderId: json['id'],
      title: json["title"],
      description: json["description"],
      triggerAt: DateTime.tryParse(json["trigger_at"]) ?? DateTime.now(),
      isRepeatingAnnually: json["is_repeating"]==0 ? false:true,
      schedules: json["schedules"] == null
          ? []
          : List<Schedule>.from(
              json["schedules"]!.map((x) => Schedule.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": reminderId,
        "title": title,
        "description": description,
        "is_repeating": isRepeatingAnnually,
        "trigger_at":
            "${triggerAt!.year.toString().padLeft(4, '0')}-${triggerAt!.month.toString().padLeft(2, '0')}-${triggerAt!.day.toString().padLeft(2, '0')}",
        "schedules": schedules.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        title,
        description,
        triggerAt,
        schedules,
        isRepeatingAnnually,
      ];
}
