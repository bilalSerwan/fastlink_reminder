import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/Provider/home_provider.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/add_reminder_screen.dart';
import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
import 'package:fastlink_reminder/screens/home/widgets/reminder_card.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/show_dialog.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    context.read<HomeProvider>().changeIsLoading(true);
    await context.read<HomeProvider>().fetchReminders();
  }

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
              builder: (context) => AddOrEditReminderScreen(
                appBarTitle: 'Add',
                reminder: Reminder(
                    reminderId: 0,
                    title: '',
                    description: '',
                    triggerAt: DateTime.tryParse(''),
                    schedules: [Schedule(amount: 0, unit: "Hour")]),
              ),
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
          IconButton(
            onPressed: () {
              context.read<AuthProvider>().logOutUser();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.all(10.r),
        child: context.watch<HomeProvider>().isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                controller: scrollController,
                itemCount: context.watch<HomeProvider>().remindersList.length,
                itemBuilder: (context, index) =>
                    context.watch<HomeProvider>().paginationLimit >= index
                        ? ReminderCard(
                            deleteButtonPressed: () async {
                              final result = await context
                                  .read<HomeProvider>()
                                  .deleteReminder(context
                                      .read<HomeProvider>()
                                      .remindersList[index]);
                              showAlertDialog(context, result);
                            },
                            editButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddOrEditReminderScreen(
                                    appBarTitle: 'Edit',
                                    reminder: context
                                        .watch<HomeProvider>()
                                        .remindersList[index],
                                  ),
                                ),
                              );
                            },
                            reminderTitle: context
                                    .watch<HomeProvider>()
                                    .remindersList[index]
                                    .title ??
                                'have error please restart the app',
                            expirationDate: DateFormat.yMMMd().format(
                              context
                                  .watch<HomeProvider>()
                                  .remindersList[index]
                                  .triggerAt!,
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
