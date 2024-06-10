import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/widgets/drop_down_button.dart';
import 'package:fastlink_reminder/utils/show_dialog.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetSchedulerCard extends StatefulWidget {
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
  State<SetSchedulerCard> createState() => _SetSchedulerCardState();
}

class _SetSchedulerCardState extends State<SetSchedulerCard> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: widget.schedule.amount.toString());
    List units = ["hour", "day", "week", "month"];
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
                controller: controller,
                validator: (value) {
                  return null;
                },
                onChanged: (value) {                
                  print(value);
                  int number;
                  try {
                    number = int.parse(value == "" ? "0" : value.trim());
                  if (number > 0 && number <= 255) {
                    widget.schedule.amount = number;
                  } else {
                    showAlertDialog(
                        context, 'the amount value must be between 0-255');
                  }
                  } catch (e) {
                    print(e);
                    number = 0;
                    showAlertDialog(
                        context, 'please only enter number in amount field');
                  }
                  
                },
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('amount'),
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
        ],
      ),
    );
  }
}
