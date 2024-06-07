import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/widgets/drop_down_button.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetSchedulerCard extends StatelessWidget {
  const SetSchedulerCard({
    super.key,
    required this.schedule,
    required this.onDeleteTap,
    required this.showError,
  });
  final Schedule schedule;
  final void Function() onDeleteTap;
  final bool showError;
  @override
  Widget build(BuildContext context) {
    List units = ["Hour","Day", "Week", "Month"];
    return Container(
      padding: EdgeInsets.all(7.w),
      margin: EdgeInsets.all(3.w),
      width: 0.92.sw,
      height: 125.h,
      decoration: showError
          ? BoxDecoration(
              color: schedule.amount == 0
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
                onTap: onDeleteTap,
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
                    calculateLengthOfTheList(schedule.unit!),
                    (index) => "${index + 1}"),
                label: schedule.unit!,
                selectedItem: schedule.amount.toString(),
                onChaned: (v) {
                  schedule.amount = int.parse(v);
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomeDropDown(
                  onChaned: (v) {
                    schedule.unit = v.toString();
                  },
                  items: units,
                  label: "Unit",
                  selectedItem: schedule.unit),
            ],
          ),
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
