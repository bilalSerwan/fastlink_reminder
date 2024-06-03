import 'dart:convert';

import 'package:fastlink_reminder/links.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future userLogin({required String email, required String password}) async {
    final response = await http.post(
        headers: {
          'Accept': 'application/json',
        },
        Uri.parse(loginApi),
        body: {'email': email, 'password': password});
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
