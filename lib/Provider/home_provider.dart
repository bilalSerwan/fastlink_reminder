import 'dart:developer';

import 'package:fastlink_reminder/Services/reminder_services.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final reminderServices = ReminderServices();
  List<Reminder> remindersList = [];
  final int paginationLimit = 10;
  int currentPagePagination = 1;
  late int lastPagepagination = 1;
  String errorMesssge = "";

  Future<void> fetchAllReminders() async {
    log('fetchAllData');
    final userToken2 = sharedPreferences.getString('user_token');
    final response = await reminderServices.fetchAllData(userToken2!);
    remindersList.clear();
    if (response['message'] == null) {
      final remindersData = response['reminders']['data'];
      for (var reminder in remindersData) {
        log('reminder => $reminder');
        remindersList.add(Reminder.fromJson(reminder));
      }
    } else {
      print('error');
    }
    notifyListeners();
  }

  Future<void> fetchReminders(bool anotherPage) async {
      String userToken = sharedPreferences.getString('user_token')!;
    if ((currentPagePagination > lastPagepagination) && anotherPage) return;
    log('fetch data runnig');
    if (anotherPage) {
      currentPagePagination++;
    } else {
      remindersList.clear();
    }
    if (currentPagePagination <= lastPagepagination) {
      log('fetch data in provider is  runnig');
      final response = await reminderServices.fetchData(userToken,
          pagenationPage: currentPagePagination);
      currentPagePagination = response['reminders']['current_page'];
      lastPagepagination = response['reminders']['last_page'];
      log('curr_page ==>$currentPagePagination &&&& last_page===>>$lastPagepagination');
      final remindersData = response['reminders']['data'];
      for (var reminder in remindersData) {
        remindersList.add(Reminder.fromJson(reminder));
      }
      notifyListeners();
    }
    notifyListeners();
    return;
  }

  Future<String> deleteReminder(Reminder reminder) async {
      String userToken = sharedPreferences.getString('user_token')!;
    log('delete reminder ==============================>');
    final result = await reminderServices.deleteReminder(
        reminderId: reminder.reminderId, userToken: userToken);
    notifyListeners();
    return result['message'];
  }

  Future<String> addReminder(Reminder reminder) async {
      String userToken = sharedPreferences.getString('user_token')!;
    final result = await reminderServices.addReminder(
        newReminder: reminder, userToken: userToken);
    return result['message'];
  }

  Future<String> updateReminder(Reminder reminder) async {
      String userToken = sharedPreferences.getString('user_token')!;
    final result = await reminderServices.updateReminder(userToken, reminder);
    return result['message'];
  }
}
