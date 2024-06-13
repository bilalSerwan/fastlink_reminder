import 'package:fastlink_reminder/drawer_screen.dart';
import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDeletePage extends StatelessWidget {
  const ConfirmDeletePage({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DrawerScreen()));
                    },
                    child: CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 75.h,
            ),
            CircleAvatar(
              radius: 70.r,
              backgroundColor: Colors.red,
              child: Center(
                child: Icon(
                  Icons.delete,
                  size: 75.r,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'Delete Account',
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(text),
            SizedBox(
              height: 10.h,
            ),
            CustomeTextField(
                controller: textController,
                validatorFunction: (v) {
                  return null;
                },
                label: 'Confirm Code',
                hintText: 'Enter Confirmation Code',
                prefixIcon: const SizedBox()),
            SizedBox(
              height: 10.h,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {},
              child: Text(
                'Delete Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
