import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/Provider/home_provider.dart';
import 'package:fastlink_reminder/Services/firebase_api.dart';
import 'package:fastlink_reminder/firebase_options.dart';
import 'package:fastlink_reminder/screens/first_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessagingService().initialize();

  sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    const MyApp(),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
          MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AuthProvider()),
            ChangeNotifierProvider(create: (context) => HomeProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            navigatorKey: navigatorKey,
          ),
        );
      },
    );
  }
}
