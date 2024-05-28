class ReminderDate {
  String type;
  DateTime? date;
  int number;
  ReminderDate(this.type, this.number);

  int claculateDays(String type, int number) {
    int days = 0;
    switch (type) {
      case "Day":
        days = number;
        break;
      case "Week":
        days = number * 7;
        break;
      case "Month":
        days = number * 31;
        break;
      case "Year":
        days = number * 365;
        break;
      default:
        days = 0;
    }
    date!.add(Duration(days: days));
    return days;
  }
}
