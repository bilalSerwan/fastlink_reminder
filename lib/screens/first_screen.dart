import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
import 'package:fastlink_reminder/screens/Auth/sign_up_screen.dart';
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
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (checkUserSignIn()) {
        if (checkTokenExpiered()) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SignInScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
            (route) => false);
      }
    });
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

  bool checkUserSignIn() {
    //if(sharedPrefrence.get('User)!=null){
    //return true
    //}else{
    //  return false
    //}
    return true;
  }

   checkTokenExpiered()async {
    return await AuthProvider().checkTokenExpiered('');
  }
}
