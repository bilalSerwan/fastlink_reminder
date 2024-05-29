import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isLoading = false;
  bool haveError = false;
  String? validationFunction(String value, int miniLentgh, int maxLentgh) {
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
void changeShowPassword(bool value){
  showPassword=value;
  notifyListeners();
}

void changeIsLoading(bool value){
  isLoading=value;
  notifyListeners();
}
void changeHaveError(bool value){
  haveError=value;
  notifyListeners();
}

}//class

