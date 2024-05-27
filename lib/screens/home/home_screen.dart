import 'package:fastlink_reminder/screens/AddReminder/add_reminder_screen.dart';
import 'package:fastlink_reminder/screens/home/widgets/reminder_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        onPressed: () {
          print('Go to Add Reminder Screen .................');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddReminderScreen(),
            ),
          );
          print('done=========================');
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Reminder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const [
            ReminderCard(
              reminderTitle: 'Reminder 1',
              exparationDay: '10/7/2024',
            ),
            ReminderCard(
              reminderTitle: 'Reminder 2',
              exparationDay: '10/7/2024',
            ),
            ReminderCard(
              reminderTitle: 'Reminder 3',
              exparationDay: '10/7/2024',
            ),
          ],
        ),
      ),
    );
  }
}
