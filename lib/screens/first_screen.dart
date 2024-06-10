// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
import 'package:fastlink_reminder/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: const Center(
            child: Image(image: AssetImage('assets/images/logo.png')),
          ),
        ),
      ),
    );
  }
}

checkToken(BuildContext context) async {
  final userToken = sharedPreferences.getString('user_token');
  log('User_Token =======> $userToken');
    final result = await AuthProvider().checkTokenExpiered(userToken!);
    if (result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  
}
