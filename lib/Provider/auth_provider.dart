import 'dart:developer';

import 'package:fastlink_reminder/Services/firebase_api.dart';
import 'package:fastlink_reminder/Services/user_services.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/model/user.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool showPassword = false;
  bool keepMeSignInButton = false;
  User user = User();
  final authService = AuthServices();

  void changeShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void changekeepMeSignInButton() {
    keepMeSignInButton = !keepMeSignInButton;
    notifyListeners();
  }

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

  Future<String> signInMethod(
      {required String email, required String password}) async {
    log("email => $email ,,, password => $password");

    String? fcmToken = await FirebaseMessagingService().getToken();
    if (fcmToken == null) {
      return 'have error in fcmToken not received ';
    }
    log('fcmToken================>$fcmToken');
    final result = await authService.loginUser(
        email: email, password: password, fcmToken: fcmToken);
    sharedPreferences.setString("fcmToken", fcmToken);
    if (result['message'] == null) {
      user = User.fromJson(result);
      print(user.userData);
      print(
          'fcmToken in shared prefrences =========${sharedPreferences.getString("fcmToken")}');
      sharedPreferences.setString("user_token", user.accessToken!);
      if (keepMeSignInButton) {
        sharedPreferences.setString("isLogin", "login");
        print(
            'user token in shared prefrences =========${sharedPreferences.getString("user_token")}');
      }
      return 'Successful';
    }
    return result['message'];
  }

  Future<String> signUpMethod(
      {required String email, required String fullName}) async {
    log('sign up method ......................');
    final result = await authService.sendEmail(
        recipientEmail: email, recipientName: fullName);
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
      final result = await authService.checkTokenExpiered(token: token);
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

  Future logOutUser() async {
    String userToken = sharedPreferences.getString('user_token')!;
    final result = await authService.logOut(userToken);
    print(result);
    print(await sharedPreferences.clear());
    sharedPreferences.clear();
    log('log out muthod runned ............................');
  }

  Future<String> destroyAccount() async {
    String userToken = sharedPreferences.getString('user_token')!;

    final result = await authService.destroyAccount(userToken);
    print(result);
    return result.data['message'];
  }

  Future<String> confirmDestroyAccount(String confirmCode) async {
    String userToken = sharedPreferences.getString('user_token')!;

    final result =
        await authService.confirmDestroyAccount(userToken, confirmCode);
    print(result);
    sharedPreferences.clear();
    return result.data['message'];
  }
}//class

