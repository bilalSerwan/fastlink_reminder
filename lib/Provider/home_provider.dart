import 'dart:convert';
import 'dart:developer';

import 'package:fastlink_reminder/Services/service.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeProvider extends ChangeNotifier {
  final apiServices = ApiServices();

  List<Reminder> reminders = [];

  void updateReminders(Response data) {
    Response response = data;
    List<Reminder> newReminders = [];
    final reminderData = jsonDecode(response.body)['reminders']['data'] as List;
    for (int i = 0; i < reminderData.length; i++) {
      newReminders.add(Reminder.fromJson(reminderData[i]));
    }
    reminders = newReminders;
  }

  Future deleteReminder(Reminder reminder) async {
    log('delete reminder ==============================>');
    // apiServices.deleteReminder();
  }

  // Future editReminder() async {
  //   log('add reminder ==============================>');
  //   apiServices.editReminder();
  // }
  // Future<void> fetchData() async {
  //   log('fetching data ==============================>');
  //   final userToken = sharedPreferences.getString('user_token');
  //   if (userToken == null) {
  //     print('user token not registered !!!!!!!!!!!!!!');
  //     return;
  //   } else {
  //     await apiServices.fetchData(userToken);
  //   }
  // }

  Future<void> addReminder(Reminder reminder) async {
    final token = sharedPreferences.getString('user_token');
    log(token!);
    final result =
        await apiServices.addReminder(reminder: reminder, token: token);

    print(result);
  }

  Future<void> updateReminder(Reminder reminder) async {
    // apiServices.editReminder();
  }
}
