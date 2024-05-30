import 'package:fastlink_reminder/Provider/home_provider.dart';
import 'package:fastlink_reminder/screens/AddReminder/add_reminder_screen.dart';
import 'package:fastlink_reminder/screens/home/widgets/reminder_card.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddReminderScreen(),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Reminder',
          style: largetext.copyWith(
              color: Colors.white, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.all(10.r),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => ReminderCard(
            deleteButtonPressed: () {
              context.read<HomeProvider>().deleteReminder();
            },
            editButtonPressed: () {
              context.read<HomeProvider>().editReminder();
            },
            reminderTitle: 'Reminder $index',
            expirationDate: 'Expiers After $index Months',
          ),
        ),
      ),
    );
  }
}
