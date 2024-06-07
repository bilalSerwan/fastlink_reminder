import 'package:fastlink_reminder/Provider/home_provider.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/add_reminder_screen.dart';
import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
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
          //create new Reminder .......................
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AddOrEditReminderScreen(appBarTitle: 'Add',reminder: Reminder(title: '',description: '',triggerAt: DateTime.tryParse(''),schedules: [Schedule(amount: 1, unit: "Hour")]),),
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
        actions: [
          IconButton(onPressed: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignInScreen()), (route) => false);
        }, icon: const Icon(Icons.logout,color: Colors.white,),),],
      ),
      
      
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.all(10.r),
        child: ListView.builder(
          itemCount: context.watch<HomeProvider>().reminders.length,
          itemBuilder: (context, index) => ReminderCard(
            deleteButtonPressed: () {
              context.read<HomeProvider>().deleteReminder();
            },
            editButtonPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>  AddOrEditReminderScreen(appBarTitle: 'Edit',reminder: context.watch<HomeProvider>().reminders[index],),),);
                        },
            reminderTitle: context.watch<HomeProvider>().reminders[index].title?? 'have error please restart the app',
            expirationDate: context.watch<HomeProvider>().reminders[index].triggerAt.toString(),
          ),
        ),
      ),
    );
  }
}
