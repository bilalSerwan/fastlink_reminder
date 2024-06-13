import 'dart:developer';

import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/screens/drawer_screen.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/screens/deleteAccountScreens/confirm_delete_page.dart';
import 'package:fastlink_reminder/utils/loading_dialog.dart';
import 'package:fastlink_reminder/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: const AssetImage('assets/images/person.png'),
                fit: BoxFit.cover,
                width: 250.w,
                height: 250.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Deleting your account is permanent and cannot be undone. Ensure you’ve backed up important data before proceeding.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Column(
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DrawerScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r)))),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () async {
                      showLoadiongDialog(context);
                      final result =
                          await context.read<AuthProvider>().destroyAccount();
                          log('current context mounted ${context.mounted}');
                         if(context.mounted){
                          Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmDeletePage(
                            text: result,
                          ),
                        ),
                      );
                         }
                    },
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
