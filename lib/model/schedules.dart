class Schedules {
  int? amount;
  String? unit;

  Schedules({this.amount, this.unit});

  Schedules.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['unit'] = unit;
    return data;
  }
}
