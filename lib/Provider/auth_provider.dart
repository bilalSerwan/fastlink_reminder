import 'dart:developer';

import 'package:fastlink_reminder/Services/service.dart';
import 'package:flutter/material.dart';

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

  Future<bool> signInMethod(
      {required String email, required String password}) async {
    log("email => $email ,,, password => $password");
    apiServices.checkUser();
    return false;
  }

  Future<bool> signUpMethod(
      {required String email, required String fullName}) async {
    log('add user ==============================> to database and send email');
    log('email ======> $email |||| fullName ======> $fullName');
    apiServices.sendEmail(email);
    ApiServices().addUser();
    return false;
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

  bool checkTokenExpiered() {
    log('check token expiered ==============================>');
    return true;
  }
}//class

