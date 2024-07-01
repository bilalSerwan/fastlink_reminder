import 'dart:developer';

import 'package:fastlink_reminder/Services/reminder_services.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final reminderServices = ReminderServices();
  String userToken = sharedPreferences.getString('user_token')!;
  List<Reminder> remindersList = [];
  final int paginationLimit = 10;
  int currentPagePagination = 1;
  late int lastPagepagination = 1;
  String errorMesssge = "";

  Future<void> fetchMoreData() async {
    log('fetch more data running');
    if (currentPagePagination > lastPagepagination) return;
    currentPagePagination++;
    if (currentPagePagination <= lastPagepagination) {
      final response = await reminderServices.fetchData(userToken,
          pagenationPage: currentPagePagination);
      currentPagePagination = response['reminders']['current_page'];
      lastPagepagination = response['reminders']['last_page'];
      final remindersData = response['reminders']['data'];
      for (var reminder in remindersData) {
        remindersList.add(Reminder.fromJson(reminder));
      }
    }
    notifyListeners();
  }

  Future<void> fetchReminders(bool anotherPage) async {
    log('fetch data runnig');
    remindersList = [];
    if (currentPagePagination <= lastPagepagination) {
      final response =
          await reminderServices.fetchData(userToken, pagenationPage: 1);
      currentPagePagination = response['reminders']['current_page'];
      lastPagepagination = response['reminders']['last_page'];
      final remindersData = response['reminders']['data'];
      for (var reminder in remindersData) {
        remindersList.add(Reminder.fromJson(reminder));
      }
    }
    notifyListeners();
    return;
  }

  Future<String> deleteReminder(Reminder reminder) async {
    log('delete reminder ==============================>');
    final result = await reminderServices.deleteReminder(
        reminderId: reminder.reminderId, userToken: userToken);
    return result['message'];
  }

  Future<String> addReminder(Reminder reminder) async {
    log('add reminder method running');
    final result = await reminderServices.addReminder(
        newReminder: reminder, userToken: userToken);
    log('add reminder data ${result}');
    remindersList.add(Reminder.fromJson(result['reminder']));
    notifyListeners();
    return result['message'];
  }

  Future<String> updateReminder(Reminder reminder) async {
    final result = await reminderServices.updateReminder(userToken, reminder);
    remindersList.add(Reminder.fromJson(result['reminder']));
    notifyListeners();
    return result['message'];
  }
}
