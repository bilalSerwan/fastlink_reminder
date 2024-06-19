// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/Provider/home_provider.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/widgets/set_reminder_date_card.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/show_dialog.dart';
import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddOrEditReminderScreen extends StatefulWidget {
  const AddOrEditReminderScreen({
    super.key,
    required this.appBarTitle,
    required this.reminder,
  });
  final String appBarTitle;
  final Reminder reminder;

  @override
  State<AddOrEditReminderScreen> createState() =>
      _AddOrEditReminderScreenState();
}

class _AddOrEditReminderScreenState extends State<AddOrEditReminderScreen> {
  _AddOrEditReminderScreenState();
  late Reminder previousReminder;
  bool selectExpirationDateHaveError = false;
  final formkey = GlobalKey<FormState>();
  List<Schedule> schedules = [];
  DateTime? triggerAt;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    previousReminder = Reminder(
      reminderId: widget.reminder.reminderId,
      title: widget.reminder.title,
      description: widget.reminder.description,
      triggerAt: widget.reminder.triggerAt,
      schedules: widget.reminder.schedules,
    );
    for (var schedule in previousReminder.schedules) {
      schedules.add(Schedule(amount: schedule.amount, unit: schedule.unit));
    }
    triggerAt = previousReminder.triggerAt;
    titleController.text = previousReminder.title ?? '';
    descriptionController.text = previousReminder.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Future<void> pickDate(BuildContext context) async {
      triggerAt = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 3650)),
        initialDate: DateTime.now(),
      );
      selectExpirationDateHaveError = false;
      setState(() {});
    }

    return SafeArea(
      child: Scaffold(
        //AppBar
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            '${widget.appBarTitle} Reminder',
            style: Theme.of(context)
                .typography
                .englishLike
                .headlineMedium!
                .copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),

        //bodyyyyyyyyyyyyyyyyyyyyyyyyyyy
        body: Container(
          width: 1.sw,
          height: 1.sh,
          padding: EdgeInsets.all(10.r),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomeTextField(
                    controller: titleController,
                    validatorFunction: (v) {
                      return context
                          .read<AuthProvider>()
                          .validationFunction(v, 5, 50);
                    },
                    label: 'Reminder Title',
                    hintText: 'Enter Reminder Title',
                    prefixIcon: Icon(
                      Icons.abc,
                      size: 20.r,
                      color: subcolor.withOpacity(0.4),
                    ),
                  ),

                  CustomeTextField(
                    controller: descriptionController,
                    isDescriptionTextForm: true,
                    validatorFunction: (v) {
                      return context
                          .read<AuthProvider>()
                          .validationFunction(v, 5, 255);
                    },
                    label: 'Reminder Description',
                    hintText: 'Enter Reminder Description',
                    prefixIcon: Icon(
                      Icons.description,
                      size: 20.r,
                      color: subcolor.withOpacity(0.4),
                    ),
                  ),

                  //in this section code user pick a expieration date
                  Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Row(
                      children: [
                        if (selectExpirationDateHaveError)
                          Icon(
                            Icons.error_outline,
                            color: Colors.red.shade700,
                          ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (triggerAt == null)
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.h, left: 5.w)),
                            Text(
                              'Exparation Date',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .typography
                                  .dense
                                  .bodyLarge!
                                  .copyWith(color: Colors.black),
                            ),
                            if (triggerAt != null)
                              Text(
                                  "${triggerAt!.day}-${triggerAt!.month}-${triggerAt!.year}"),
                          ],
                        ),
                        const Spacer(),
                        CupertinoButton(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                          padding: EdgeInsets.all(15.r),
                          child: const Text('Pick Date'),
                          onPressed: () async {
                            await pickDate(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  //in this section code we have only reminder text and reminder add button to add reminders
                  Padding(
                    padding: EdgeInsets.all(10.0.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text('Reminders', style: subtitle),
                        ),
                        InkWell(
                          onTap: () {
                            schedules.add(
                              Schedule(amount: 0, unit: "day"),
                            );
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 15.r,
                            child: CircleAvatar(
                              radius: 13.r,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.add,
                                size: 20.sp,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Column(
                      children: [
                        for (int i = 0; i < schedules.length; i++)
                          SetSchedulerCard(
                            schedule: schedules[i],
                            onDeleteTap: () {
                              schedules.remove(schedules[i]);
                              setState(() {});
                            },
                            iseditting: widget.appBarTitle == "Edit",
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //Save Button
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(primaryColor)),
            onPressed: () async {
              log('button pressed');
              if (formkey.currentState!.validate()) {
                if (triggerAt == null) {
                  selectExpirationDateHaveError = true;
                  setState(() {});
                  return;
                }
                for (var schedule in schedules) {
                  if (schedule.haveError) {
                    return;
                  } else {
                    schedule.amount = int.parse(schedule.controller.text);
                  }
                }
                log('valid data');
                final newReminder = Reminder(
                    reminderId: previousReminder.reminderId,
                    title: titleController.text,
                    description: descriptionController.text,
                    triggerAt: triggerAt,
                    schedules: schedules);
                print('newReminder===============>$newReminder');
                print('previousReminder===============>$previousReminder');
                if (newReminder != previousReminder ||
                    schedulescheck(
                        newReminder.schedules, previousReminder.schedules)) {
                  log('add Or Edit reminder ...................');
                  final result = widget.appBarTitle == "Add"
                      ? await context
                          .read<HomeProvider>()
                          .addReminder(newReminder)
                      : await context
                          .read<HomeProvider>()
                          .updateReminder(newReminder);
                  showAlertDialog(context, result.toString(),
                      editOrAddReminder: true);
                }
              }
            },
            child: Text(
              'Save',
              style: buttonTextStyle.copyWith(
                fontSize: 26.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool schedulescheck(List<Schedule> schedule1, List<Schedule> schedule2) {
    if (schedule1.length != schedule2.length) {
      return true;
    } else {
      for (int i = 0; i < schedule1.length; i++) {
        if (schedule1[i] != schedule2[i]) {
          return true;
        }
      }
    }
    return false;
  }
}
