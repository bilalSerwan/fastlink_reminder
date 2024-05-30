import 'dart:developer';

import 'package:fastlink_reminder/Services/service.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final apiServices = ApiServices();


  List reminders=[];

  Future deleteReminder() async {
    log('delete reminder ==============================>');
    apiServices.deleteReminder();
  }

  Future editReminder() async {
    log('add reminder ==============================>');
    apiServices.editReminder();
  }
  Future<void> fetchData()async{
    apiServices.fetchData();
  }
}
