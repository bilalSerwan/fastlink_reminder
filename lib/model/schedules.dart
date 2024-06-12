// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  Schedule({
    required this.amount,
    required this.unit,
  });

  int? amount;
  String? unit;

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

  @override
  List<Object?> get props => [
        amount,
        unit,
      ];
}
