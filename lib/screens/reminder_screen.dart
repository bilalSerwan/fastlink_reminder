import 'package:fastlink_reminder/model/reminder.dart';
import 'package:fastlink_reminder/screens/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key, required this.reminder});
  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10.w),
          child: ListView(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image(
                      image: const AssetImage('assets/images/reminder.jpg'),
                      width: 0.92.sw,
                      fit: BoxFit.cover,
                      height: 0.3.sh,
                    ),
                  ),
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DrawerScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Title : ${reminder.title}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(reminder.description),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Expire date : ${DateFormat.yMMMd().format(reminder.triggerAt!)}',
                style: const TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Schedules',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.h,
              ),
              for (var schedule in reminder.schedules)
                Text(
                  'Schedule  : ${schedule.calculateDate(reminder.triggerAt!)} ',
                  style: TextStyle(fontSize: 15.sp),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
