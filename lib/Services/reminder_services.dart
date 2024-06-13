import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fastlink_reminder/links.dart';
import 'package:fastlink_reminder/model/reminder.dart';

class ReminderServices {
  final dio = Dio();
  Future fetchData(String userToken, {required int pagenationPage}) async {
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Accept': 'application/json',
    };

    try {
      final response = await dio.get(
          '$fetchAllRemindersApi?page=$pagenationPage',
          options: Options(headers: headers));
      return response.data;
    } catch (e) {
      log('Error fetching data: $e');
      return null;
    }
  }

  /// Adds a new reminder to the server by sending a POST request to the add reminder API endpoint.
  ///
  /// Parameters:
  /// - [newReminder]: The reminder to be added.
  /// - [userToken]: The user's authentication token.
  ///
  /// Returns:
  /// A [Future] that completes with the decoded JSON response from the server.
  Future addReminder(
      {required Reminder newReminder, required String userToken}) async {
    // Set the headers for the request.
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };

    // Convert the schedules of the reminder to a list of maps.
    List<Map<String, dynamic>> schedules = newReminder.schedules
        .map((schedule) => {
              'amount': schedule.amount,
              'unit': schedule.unit!.toLowerCase(),
            })
        .toList();

    // Send the POST request to the add reminder API endpoint.
    final response = await dio.post(
      addReminderApi,
      options: Options(headers: headers),
      data: {
        'title': newReminder.title,
        'description': newReminder.description,
        'trigger_at': newReminder.triggerAt!.toString(),
        'schedules': schedules,
      },
    );

    // Return the decoded JSON response from the server.
    return response.data;
  }

  Future updateReminder(String token, Reminder reminder) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    // Convert the schedules of the reminder to a list of maps.
    List<Map<String, dynamic>> schedules = reminder.schedules
        .map((schedule) => {
              'amount': schedule.amount,
              'unit': schedule.unit!.toLowerCase(),
            })
        .toList();

    final response = await dio.post(
      '$updateReminderAPI/${reminder.reminderId}/update',
      options: Options(headers: headers),
      data: {
        "title": reminder.title,
        "description": reminder.description,
        "trigger_at": reminder.triggerAt!.toString(),
        "schedules": schedules,
      }, //body
    ); //post
    return response.data;
  }

  deleteReminder({required String userToken, required int reminderId}) async {
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };
    final url = '$deleteReminderApi/$reminderId/delete';
    print('delete url =======>$url');
    final response = await dio.post(url, options: Options(headers: headers));
    return response.data;
  }
}
