import 'dart:ui';

import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showLoadiongDialog(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          width: 0.5.sw,
          height: 140.h,
          margin: EdgeInsets.all(10.h),
          padding: EdgeInsets.all(15.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.w,
                height: 50.w,
                child: const CircularProgressIndicator(
                  color: Colors.black,
                  strokeAlign: 2,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Loading.....',
                style: subtitle.copyWith(
                  fontSize: 20.sp,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
