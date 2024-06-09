import 'package:equatable/equatable.dart';
import 'package:fastlink_reminder/model/schedules.dart';

// ignore: must_be_immutable
class Reminder extends Equatable {
    Reminder({
        required this.title,
        required this.description,
        required this.triggerAt,
        required this.schedules,
    });

     String? title;
     String? description;
     DateTime? triggerAt;
     List<Schedule> schedules;

    Reminder copyWith({
        String? title,
        String? description,
        DateTime? triggerAt,
        List<Schedule>? schedules,
    }) {
        return Reminder(
            title: title ?? this.title,
            description: description ?? this.description,
            triggerAt: triggerAt ?? this.triggerAt,
            schedules: schedules ?? this.schedules,
        );
    }

    factory Reminder.fromJson(Map<String, dynamic> json){ 
        return Reminder(
            title: json["title"],
            description: json["description"],
            triggerAt: DateTime.tryParse(json["trigger_at"] ?? ""),
            schedules: json["schedules"] == null ? [] : List<Schedule>.from(json["schedules"]!.map((x) => Schedule.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "trigger_at": "${triggerAt!.year.toString().padLeft(4,'0')}-${triggerAt!.month.toString().padLeft(2,'0')}-${triggerAt!.day.toString().padLeft(2,'0')}",
        "schedules": schedules.map((x) => x.toJson()).toList(),
    };

    @override
    List<Object?> get props => [
    title, description, triggerAt, schedules, ];
}

