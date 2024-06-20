import 'package:fastlink_reminder/model/reminder.dart';
import 'package:fastlink_reminder/screens/drawer_screen.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
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
                  Center(
                    // top: 75.r,
                    // left: 90.r,
                    child: Container(
                      padding: EdgeInsets.only(top: 70.r),
                      width: 200.w,
                      height: 100.h,
                      child: Text(
                        reminder.title,
                        textAlign: TextAlign.center,
                        style: subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
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
                style: TextStyle(color: Colors.red, fontSize: 17.sp),
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
              Padding(
                padding: EdgeInsets.all(10.r),
                child: Table(
                  border: TableBorder.all(color: Colors.indigo),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        border: Border.all(color: Colors.black),
                      ),
                      children: [
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: Text(
                              'By Text',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.sp),
                            ),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: Text(
                              'By Date',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...List.generate(
                      reminder.schedules.length,
                      (index) => TableRow(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo),
                        ),
                        children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: Text(
                                'before ${reminder.schedules[index].amount.toString()} ${reminder.schedules[index].unit}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.sp),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: Text(
                                reminder.schedules[index]
                                    .calculateDate(reminder.triggerAt!),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
