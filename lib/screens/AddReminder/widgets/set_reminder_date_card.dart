import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/widgets/drop_down_button.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetSchedulerCard extends StatefulWidget {
  SetSchedulerCard({
    super.key,
    required this.schedule,
    required this.onDeleteTap,
    required this.iseditting,
  }) {
    if (iseditting) {
      schedule.controller.text = schedule.amount.toString();
    }
  }
  final Schedule schedule;
  final void Function() onDeleteTap;
  final bool iseditting;

  @override
  State<SetSchedulerCard> createState() => _SetSchedulerCardState();
}

class _SetSchedulerCardState extends State<SetSchedulerCard> {
  final regEx = RegExp('^[0-9]+\$');
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    List units = ["hour", "day", "week", "month"];
    return Container(
      padding: EdgeInsets.all(7.w),
      margin: EdgeInsets.all(3.w),
      width: 0.92.sw,
      height: 140.h,
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
                onTap: widget.onDeleteTap,
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
              TextFormField(
                controller: widget.schedule.controller,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    widget.schedule.haveError = true;
                    errorMessage = "amount field is required";
                  } else {
                    if (regEx.hasMatch(value)) {
                      final num = int.parse(value);
                      if (0 < num && num <= 255) {
                        widget.schedule.haveError = false;
                        errorMessage = "";
                        setState(() {});
                        return null;
                      } else {
                        widget.schedule.haveError = true;
                        errorMessage =
                            "The amount field must be a number between 0-255";
                      }
                    } else {
                      widget.schedule.haveError = true;
                      errorMessage =
                          "Please only enter numbers in amount field";
                    }
                  }
                  setState(() {});
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('amount'),
                  alignLabelWithHint: true,
                  hintText: widget.schedule.amount == 0
                      ? null
                      : '${widget.schedule.amount}',
                  constraints: BoxConstraints(maxWidth: 100.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomeDropDown(
                  onChaned: (v) {
                    widget.schedule.unit = v.toString();
                  },
                  items: units,
                  label: 'Unit',
                  selectedItem: widget.schedule.unit),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          widget.schedule.haveError
              ? Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 15.r,
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Text(
                      errorMessage,
                      style: TextStyle(
                          color: Colors.red.shade800, fontSize: 10.sp),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
