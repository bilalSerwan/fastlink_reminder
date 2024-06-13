import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
import 'package:fastlink_reminder/screens/deleteAccountScreens/delete_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
      width: 0.7.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.20.sh,
          ),
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
            height: 20.h,
          ),
          Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.group,
                  color: Colors.white,
                  size: 18.sp,
                ),
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  'Fastlink Team',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                )
              ],
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
            onPressed: () {
              context.read<AuthProvider>().logOutUser();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (route) => false);
            },
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeleteAccount(),
                ),
              );
            },
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
