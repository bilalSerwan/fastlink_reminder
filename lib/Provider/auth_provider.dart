import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool showPassword = false;
  bool isLoading = false;
  bool checkBoxValue = false;
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

  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void changeCheckBoxValue() {
    checkBoxValue = !checkBoxValue;
    notifyListeners();
  }
}//class

