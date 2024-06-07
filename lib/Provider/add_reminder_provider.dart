
import 'package:fastlink_reminder/model/reminder.dart';
// import 'package:fastlink_reminder/model/schedules.dart';
import 'package:flutter/cupertino.dart';

class AddReminderProvider extends ChangeNotifier{
  late  Reminder editOrNewReminder;
  bool haveErrorInScheduler = false;
  bool selectExpirationDateHaveError = false;

  void changeReminder(Reminder newReminder){
    editOrNewReminder = newReminder;
    print(editOrNewReminder);
    notifyListeners();
  }
  void changeSelectExpirationDateHaveError(bool newValue){
    selectExpirationDateHaveError=newValue;
    notifyListeners();
  }
  void changeHaveErrorInScheduler(bool newValue){
    haveErrorInScheduler=newValue;
    notifyListeners();
  }
}