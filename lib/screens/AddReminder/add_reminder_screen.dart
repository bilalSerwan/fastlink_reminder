// ignore_for_file: must_be_immutable

import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/widgets/set_reminder_date_card.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController titleController = TextEditingController();

  DateTime? selectExpierationDate;

  Future<void> pickDate(BuildContext context) async {
    selectExpierationDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      initialDate: DateTime.now(),
    );
    selectexpirationDateHaveError = false;
    setState(() {});
  }

  List<Schedules> schedules = [
    Schedules(amount: 0, unit: "day"),
  ];
  bool selectexpirationDateHaveError = false;
  bool haveError = false;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //AppBar
        appBar: AppBar(
          title: Text(
            'Add Reminder',
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
                  //user set reminder Title in this text field
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

                  //in this comment code user pick a expieration date
                  Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Row(
                      children: [
                        if (selectexpirationDateHaveError)
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
                            if (selectExpierationDate == null)
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
                            if (selectExpierationDate != null)
                              Text(
                                  "${selectExpierationDate!.day}-${selectExpierationDate!.month}-${selectExpierationDate!.year}"),
                          ],
                        ),
                        const Spacer(),
                        CupertinoButton(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.r),
                          ),
                          padding: EdgeInsets.all(10.r),
                          child: const Text('Pick Date'),
                          onPressed: () async {
                            await pickDate(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  //in this section code we have only reminders text and reminder add button to add reminders
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                              Schedules(amount: 1, unit: "day"),
                            );
                            haveError = false;
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 15,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.add,
                                size: 20,
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
                          SetReminderDateCard(
                            schedule: schedules[i],
                            onTap: () {
                              schedules.remove(schedules[i]);
                              setState(() {});
                            },
                            showError: haveError,
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
                backgroundColor: MaterialStateProperty.all(primaryColor)),
            onPressed: () {
              if (formkey.currentState!.validate()) {
                if (selectExpierationDate == null) {
                  selectexpirationDateHaveError = true;
                  setState(() {});
                  return;
                }
                for (var element in schedules) {
                  if (element.amount == 0) {
                    haveError = true;
                    setState(() {});
                    return;
                  }
                }
                return;
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
}
