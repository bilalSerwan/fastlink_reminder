import 'dart:developer';

import 'package:fastlink_reminder/Services/service.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:fastlink_reminder/model/schedules.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final apiServices = ApiServices();

  List<Reminder> reminders=[Reminder(title: 'do meeting',triggerAt: DateTime(2025,7,30),description: "it's one of the important meetings", schedules: [Schedule(amount: 4, unit:'Week'),],),];



  Future deleteReminder() async {
    log('delete reminder ==============================>');
    apiServices.deleteReminder();
  }

  // Future editReminder() async {
  //   log('add reminder ==============================>');
  //   apiServices.editReminder();
  // }
  Future<void> fetchData()async{
    apiServices.fetchData();
  }
}
