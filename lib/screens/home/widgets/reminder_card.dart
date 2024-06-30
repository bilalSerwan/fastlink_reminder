import 'package:fastlink_reminder/screens/home/widgets/slidable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    super.key,
    required this.reminderTitle,
    required this.expirationDate,
    required this.deleteButtonPressed,
    required this.editButtonPressed,
  });
  final String reminderTitle;
  final String expirationDate;
  final void Function() deleteButtonPressed;
  final void Function() editButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),

        //slidable Buttons delete and edit
        children: [
          SlidableButton(
            buttonColor: Colors.red,
            buttonIcon: Icons.delete,
            buttonName: 'Delete',
            buttonPressed: deleteButtonPressed,
          ),
          SlidableButton(
            buttonColor: Colors.grey,
            buttonIcon: Icons.edit,
            buttonName: 'Edit',
            buttonPressed: editButtonPressed,
          ),
        ],
      ),
      child: Container(
        width: 0.92.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 2,
              spreadRadius: 3,
              offset: const Offset(0, 6),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
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
              expirationDate,
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
