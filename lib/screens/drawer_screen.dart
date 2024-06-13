import 'package:fastlink_reminder/screens/home/home_screen.dart';
import 'package:fastlink_reminder/screens/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreen: const HomeScreen(),
      menuScreen: const CustomDrawer(),
      showShadow: true,
      borderRadius: 24.r,
      drawerShadowsBackgroundColor: Colors.grey[300]!,
      menuBackgroundColor: Colors.indigo,
      style: DrawerStyle.defaultStyle,
    );
  }
}
