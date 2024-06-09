import 'dart:convert';

import 'package:fastlink_reminder/links.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  /// Logs in a user using the provided email, password, and FCM token.
  ///
  /// Parameters:
  /// - [email]: The user's email.
  /// - [password]: The user's password.
  /// - [fcmToken]: The user's FCM token.
  ///
  /// Returns:
  /// A [Future] that completes with the decoded JSON response from the server.
  Future loginUser(
      {required String email,
      required String password,
      required String fcmToken}) async {
    // Send a POST request to the login API with the provided email, password, and FCM token.
    try {
      final response = await http.post(
          headers: {
            'Accept': 'application/json',
          },
          Uri.parse(loginApi),
          body: {
            'email': email,
            'password': password,
            'fcm_token': fcmToken,
          });

      // Print the decoded JSON response for debugging purposes.
      print(jsonDecode(response.body));

      // Return the decoded JSON response.
      return jsonDecode(response.body);
    } catch (e) {
      print('Error in login user =========>${e.toString()}');
    }
    return {};
  }

  addReminder({required Reminder reminder, required String token}) async {
    List<Map<String, dynamic>> schedules = [];
    for (int i = 0; i < reminder.schedules.length; i++) {
      schedules.add({
        "amount": reminder.schedules[i].amount,
        "unit": reminder.schedules[i].unit!.toLowerCase()
      });
    }
    // try {
    final response = await http.post(
      Uri.parse(addReminderApi),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        "title": reminder.title,
        "description": reminder.description,
        "trigger_at": reminder.triggerAt!.toString(),
        "schedules": [
          {"amount": 4, "unit": "week"},
          {"amount": 1, "unit": "day"}
        ],
      }, //body
    ); //post
    print(jsonDecode(response.body).toString());
    // return jsonDecode(response.body);
    // } catch (e) {
    //   print('error  ====>${e.toString()}');
    //   print(e.toString());
    // }
  }
  //add reminder method

  editReminder() {}

  deleteReminder() {}

  Future sendEmail({required String email, required String name}) async {
    try {
      final response = await http.post(
          headers: {'Accept': 'application/json'},
          Uri.parse(registerApi),
          body: {
            'name': name,
            'email': email,
          });
      return jsonDecode(response.body);
    } catch (e) {
      print('Error in sending messege===>${e.toString()}');
    }
    return {};
  }

  Future fetchData(String userToken) async {
    try {
      return http.get(Uri.parse(fetchAllReminders), headers: {
        'Authorization': 'Bearer $userToken',
        'Accept': 'application/json'
      });
    } catch (e) {
      print('Error in fetching data============>${e.toString()}');
    }
    // print(jsonDecode(response.body));
    // return jsonDecode(response.body);
  }

  checkTokenExpiered({required String token}) async {
    try {
      final response = await http.get(Uri.parse(checktokenApi), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });
      print('response ================>${jsonDecode(response.body)}');
      return jsonDecode(response.body);
    } catch (e) {
      print('error in check token expiered =========>${e.toString()}');
    }
  }
}
