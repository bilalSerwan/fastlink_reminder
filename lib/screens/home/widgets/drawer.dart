import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
      width: 0.7.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50.r,
            child: CircleAvatar(
              radius: 48.r,
              backgroundImage: const NetworkImage(
                'https://cdn.dribbble.com/users/6054396/screenshots/14215991/media/3da34f2d510fd402fb92a89de93d7d9c.png',
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          OutlinedButton(
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(140.w, 40.h)),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.white))),
            onPressed: () {},
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(140.w, 40.h)),
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () {},
            child: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
