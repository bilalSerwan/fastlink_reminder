import 'dart:developer';

import 'package:fastlink_reminder/Services/firebase_api.dart';
import 'package:fastlink_reminder/Services/service.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/model/user.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool showPassword = false;
  bool keepMeSignInButton = false;
  User user = User();
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

  void changekeepMeSignInButton() {
    keepMeSignInButton = !keepMeSignInButton;
    notifyListeners();
  }

  Future<String> signInMethod(
      {required String email, required String password}) async {
    log("email => $email ,,, password => $password");

    String? fcmToken = await FireBaseAPI().getFCMToken();
    if (fcmToken == null) {
      return 'have error in fcmToken not received ';
    }
    log('fcmToken================>$fcmToken');
    final result = await apiServices.loginUser(
        email: email, password: password, fcmToken: fcmToken);
    sharedPreferences.setString("fcmToken", fcmToken);
    if (result['message'] == null) {
      user = User.fromJson(result);
      print(user.userData);
      print(
          'fcmToken in shared prefrences =========${sharedPreferences.getString("fcmToken")}');
      if (keepMeSignInButton) {
        sharedPreferences.setString("user_token", user.accessToken!);
        print(
            'user token in shared prefrences =========${sharedPreferences.getString("user_token")}');
      }
      return 'Successful';
    }
    return result['message'];
  }

  Future<String> signUpMethod(
      {required String email, required String fullName}) async {
    final result = await apiServices.sendEmail(email: email, name: fullName);
    return result['message'];
  }

  /// Checks if the given email is valid.
  /// Returns [true] if the email is valid, [false] otherwise.
  bool validEmail(String email) {
    // Print the email for debugging purposes.
    log(email);

    // Define the regex pattern for validating the email.
    final regExPattern = RegExp(r"^[a-zA-Z.][a-zA-Z0-9.]*$");

    // Check if the email matches the regex pattern.
    // If it does, return true, else return false.
    return regExPattern.hasMatch(email);
  }

  ///Checks the validity of the given token by sending a request to the server and parsing the response.
  ///
  /// [token] The token to check.
  ///
  /// Returns [true] if the token is expired or invalid, [false] otherwise.
  Future<bool> checkTokenExpiered(String token) async {
    log('check token expired =================> $token');

    try {
      final result = await apiServices.checkTokenExpiered(token: token);
      print(result);
      // If the response contains a "user" key, the token is valid and we can parse the user data
      if (result['user'] != null) {
        print('initialize user ===============================');
        user = User.fromJson(result);
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  } //checkTokenExpiered-method
}//class

