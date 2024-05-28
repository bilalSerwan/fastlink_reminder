import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlidableButton extends StatelessWidget {
  const SlidableButton({
    super.key,
    required this.buttonName,
    required this.buttonColor,
    required this.buttonIcon,
  });
  final String buttonName;
  final Color buttonColor;
  final IconData buttonIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('$buttonName Reminder ..........................');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.w),
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15.w),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                buttonIcon,
                color: Colors.white,
              ),
              SizedBox(
                height: 5.w,
              ),
              Text(
                buttonName,
                style: Theme.of(context).typography.englishLike.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
