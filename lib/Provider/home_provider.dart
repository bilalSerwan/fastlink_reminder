import 'dart:developer';

import 'package:fastlink_reminder/Services/reminder_services.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final reminderServices = ReminderServices();
  String userToken = sharedPreferences.getString('user_token')!;
  bool isLoading = false;
  List<Reminder> remindersList = [];
  final int paginationLimit = 10;
  int currentPagePagination = 1;
  late int lastPagepagination = 1;
  String errorMesssge = "";
  
  void changeIsLoading(bool newValue) {
    isLoading = newValue;
    notifyListeners();
  }

  Future<void> fetchReminders() async {
    log('fetch data runnig');
    if (currentPagePagination <= lastPagepagination) {
      final response = await reminderServices.fetchData(userToken,
          pagenationPage: currentPagePagination);
      currentPagePagination = response['reminders']['current_page'];
      lastPagepagination = response['reminders']['last_page'];
      log('curr_page ==>$currentPagePagination &&&& last_page===>>$lastPagepagination');
      currentPagePagination++;
      final remindersData = response['reminders']['data'];
      for (var reminder in remindersData) {
        remindersList.add(Reminder.fromJson(reminder));
      }
    }
    print(remindersList);
    changeIsLoading(false);
    return;
  }

  Future<String> deleteReminder(Reminder reminder) async {
    log('delete reminder ==============================>');
    final result = await reminderServices.deleteReminder(
        reminderId: reminder.reminderId!, userToken: userToken);
    return result['message'];
  }

  Future<String> addReminder(Reminder reminder) async {
    log('add reminder method running');
    log(userToken);
    final result = await reminderServices.addReminder(
        newReminder: reminder, userToken: userToken);
    print(result);

    return result['message'];
  }

  Future<String> updateReminder(Reminder reminder) async {
    final result = await reminderServices.updateReminder(userToken, reminder);
    return result['message'];
  }
}
