import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/widgets/drop_down_button.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetReminderDateCard extends StatefulWidget {
  const SetReminderDateCard({
    super.key,
    required this.schedule,
    required this.onTap,
    required this.showError,
  });
  final Schedules schedule;
  final void Function() onTap;
  final bool showError;
  @override
  State<SetReminderDateCard> createState() => _SetReminderDateCardState();
}

class _SetReminderDateCardState extends State<SetReminderDateCard> {
  @override
  Widget build(BuildContext context) {
    List items = ["Day", "Week", "Month"];
    return Container(
      padding: EdgeInsets.all(7.w),
      margin: EdgeInsets.all(3.w),
      width: 0.92.sw,
      height: 125.h,
      decoration: widget.showError
          ? BoxDecoration(
              color: widget.schedule.amount == 0
                  ? Colors.red[500]!.withOpacity(0.3)
                  : Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            )
          : const BoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reminde Me After:',
                style: subtitle,
              ),
              InkWell(
                onTap: widget.onTap,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: CircleAvatar(
                  radius: 15.w,
                  backgroundColor: Colors.red,
                  child: const Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              CustomeDropDown(
                items: List.generate(
                    calculateLengthOfTheList(widget.schedule.unit!),
                    (index) => "${index + 1}"),
                label: widget.schedule.unit!,
                selectedItem: widget.schedule.amount.toString(),
                onChaned: (v) {
                  widget.schedule.amount = int.parse(v);
                  // print(
                  //   widget.reminderDate.claculateDays(
                  //       widget.reminderDate.type, widget.reminderDate.number),
                  // );
                  setState(() {});
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomeDropDown(
                  onChaned: (v) {
                    widget.schedule.unit = v.toString();
                    setState(() {});
                  },
                  items: items,
                  label: "Type",
                  selectedItem: widget.schedule.unit),
            ],
          ),

          //dwayy agar waxt habw zead dakayn
          // SizedBox(
          //   height: 5.h,
          // ),
          // Text(
          //     "We Reminder You In ${reminderDates[i].date!.day}-${reminderDates[i].date!.month}-${reminderDates[i].date!.year}"),
        ],
      ),
    );
  }
}

int calculateLengthOfTheList(String type) {
  switch (type) {
    case "Day":
      return 31;
    case "Week":
      return 52;
    case "Month":
      return 12;
    case "Year":
      return 10;
    default:
      return 21;
  }
}
