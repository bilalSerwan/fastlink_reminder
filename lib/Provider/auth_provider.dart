import 'dart:convert';
import 'dart:developer';

import 'package:fastlink_reminder/Services/firebase_api.dart';
import 'package:fastlink_reminder/Services/service.dart';
import 'package:fastlink_reminder/links.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool showPassword = false;
  bool keepMeSignInButton = false;
  late User user;
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

  

  Future<String?> signInMethod(
      {required String email, required String password}) async {
    log("email => $email ,,, password => $password");
    
    String? fcm_token = await FireBaseAPI().getFCMToken();
    if(fcm_token==null) { return'';}
    final result = await apiServices.loginUser(email: email, password: password,fcm_token:fcm_token);
    sharedPreferences.setString("fcm_token", fcm_token);
    if (result['message'] == null) {
      user = User.fromJson(result);
      print(user.userData!.name);
        print('fcm_token =========${sharedPreferences.getString("fcm_token")}');
      if(keepMeSignInButton){
        sharedPreferences.setString("user_token", user.accessToken!);
        print('user token =========${sharedPreferences.getString("user_token")}');
      }
      return null;
    } 
    return result['message'];
  }

  Future<String> signUpMethod(
      {required String email, required String fullName}) async {
    final result = await apiServices.sendEmail(email: email, name: fullName);
    return result['message'];
  }

  bool validEmail(String email) {
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
    late final result;
    try{
    var response = await http.get(Uri.parse(checktokenApi), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    });
     result = jsonDecode(response.body);
    print(result);
    }catch(e){
      print(e.toString());
    }
    if(result['user']!=null){
      user=User.fromJson(result['user']);
      return false;
    }else{
      return true;
    }
    
      }//checkTokenExpiered-method

}//class

