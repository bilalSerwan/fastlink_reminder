import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showLoadiongDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: Container(
        width: 0.9.sw,
        height: 170.h,
        margin: EdgeInsets.all(10.h),
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Loading.....',
              style: subtitle.copyWith(
                fontSize: 30.sp,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 80.w,
              height: 80.w,
              child: const CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
  await Future.delayed(
    const Duration(seconds: 2),
  );
}