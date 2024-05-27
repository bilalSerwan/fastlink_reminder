import 'package:flutter/material.dart';
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
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          InkWell(
            onTap: () {
              print('Remove Reminder ..........................');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: 75,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Delete',
                      style: Theme.of(context).typography.englishLike.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('Remove Reminder ..........................');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              width: 75,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Edit',
                      style: Theme.of(context).typography.englishLike.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.92,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            color: Colors.pink,
          ),
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reminderTitle,
              style: Theme.of(context)
                  .typography
                  .englishLike
                  .bodyMedium!
                  .copyWith(color: Colors.black, fontSize: 20),
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
