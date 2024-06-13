// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:jiffy/jiffy.dart';

class Schedule extends Equatable {
  Schedule({
    required this.amount,
    required this.unit,
  });

  int amount;
  String unit;

  Schedule copyWith({
    int? amount,
    String? unit,
  }) {
    return Schedule(
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      amount: json["amount"],
      unit: json["unit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "unit": unit,
      };

  String calculateDate(DateTime triggerAt) {
    if (unit == "day") {
      return Jiffy.parse(triggerAt.toString()).subtract(days: amount).yMMMMdjm;
    } else if (unit == "week") {
      return Jiffy.parse(triggerAt.toString()).subtract(weeks: amount).yMMMMdjm;
    } else if (unit == "month") {
      return Jiffy.parse(triggerAt.toString())
          .subtract(months: amount)
          .yMMMMdjm;
    } else {
      return Jiffy.parse(triggerAt.toString()).subtract(hours: amount).yMMMMdjm;
    }
  }

  @override
  List<Object?> get props => [
        amount,
        unit,
      ];
}
