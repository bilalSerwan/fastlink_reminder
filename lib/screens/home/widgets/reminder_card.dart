import 'package:fastlink_reminder/screens/home/widgets/slidable_button.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.reminderTitle,
    required this.exparationDay,
  });
  final String reminderTitle;
  final String exparationDay;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: const ActionPane(
        motion: ScrollMotion(),

        //slidable Buttons delete and edit 
        children: [
          SlidableButton(
            buttonColor: Colors.red,
            buttonIcon: Icons.delete,
            buttonName: 'Delete',
          ),
          SlidableButton(
              buttonColor: Colors.grey,
              buttonIcon: Icons.edit,
              buttonName: 'Edit'),
        ],
      ),

      
      child: Container(
        width: 0.92.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
          border: Border.all(
            color: primaryColor,
          ),
        ),
        margin: EdgeInsets.all(5.r),
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reminderTitle,
              style: Theme.of(context)
                  .typography
                  .englishLike
                  .bodyMedium!
                  .copyWith(color: Colors.black, fontSize: 20.sp),
            ),
            Text(
              exparationDay,
              style: Theme.of(context)
                  .typography
                  .englishLike
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
