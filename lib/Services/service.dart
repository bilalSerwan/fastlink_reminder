import 'dart:convert';

import 'package:fastlink_reminder/links.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future loginUser({required String email, required String password, required String fcm_token}) async {
    final response = await http.post(
        headers: {
          'Accept': 'application/json',
        },
        Uri.parse(loginApi),
        body: {'email': email, 'password': password,'fcm_token':fcm_token});
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  addUser() {}

  addReminder() {}

  editReminder() {}

  deleteReminder() {}

  Future sendEmail({required String email, required String name}) async {
    final response = await http.post(
        headers: {'Accept': 'application/json'},
        Uri.parse(registerApi),
        body: {
          'name': name,
          'email': email,
        });
    return jsonDecode(response.body);
  }

  void fetchData() {}
}
