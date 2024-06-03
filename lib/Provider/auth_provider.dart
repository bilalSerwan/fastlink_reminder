import 'dart:convert';
import 'dart:developer';

import 'package:fastlink_reminder/Services/service.dart';
import 'package:fastlink_reminder/links.dart';
import 'package:fastlink_reminder/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool showPassword = false;
  bool checkBoxValue = false;
  final apiServices = ApiServices();

  String? validationFunction(String? value, int miniLentgh, int maxLentgh) {
    if (value == null) return 'This field is required';
    if (value.trim().isEmpty) {
      return 'This field is required';
    }
    if (value.trim().length < miniLentgh) {
      return 'This field must be at least $miniLentgh characters';
    }
    if (value.trim().length > maxLentgh) {
      return 'This field must be at most $maxLentgh characters';
    }
    return null;
  }

  void changeShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void changeCheckBoxValue() {
    checkBoxValue = !checkBoxValue;
    notifyListeners();
  }

  Future<String?> signInMethod(
      {required String email, required String password}) async {
    log("email => $email ,,, password => $password");
    final result =
        await apiServices.userLogin(email: email, password: password);
    if (result['message'] == null) {
      final user = User.fromJson(result);
      print(user.userData!.name);
      return null;
    } 
    return result['message'];
  }

  Future<String> signUpMethod(
      {required String email, required String fullName}) async {
    log('email ======> $email |||| fullName ======> $fullName');
    final result = await apiServices.sendEmail(email: email, name: fullName);
    log("Result ===================>>>>>>>>>>$result");
    return result['message'];
  }

  Future addReminder() async {
    log('add reminder ==============================>');
    apiServices.addReminder();
  }

  bool checkEmail(String email) {
    print(email);
    final regExPattern = RegExp("^[a-zA-Z.][a-zA-Z0-9.]*\$");
    if (regExPattern.hasMatch(email)) {
      print("valid Email");
      return true;
    } else {
      print('inValidEmail');
      return false;
    }
  }

  Future<bool> checkTokenExpiered(String token) async {
    var response = await http.get(Uri.parse(checktokenApi), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    });
    final result = jsonDecode(response.body);
    print(result);
    return true;
  }
}//class

