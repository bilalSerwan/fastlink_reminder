import 'package:fastlink_reminder/Provider/home_provider.dart';
import 'package:fastlink_reminder/main.dart';
import 'package:fastlink_reminder/model/reminder.dart';
import 'package:fastlink_reminder/model/schedules.dart';
import 'package:fastlink_reminder/screens/AddReminder/add_reminder_screen.dart';
import 'package:fastlink_reminder/screens/home/widgets/reminder_card.dart';
import 'package:fastlink_reminder/utils/colors.dart';
import 'package:fastlink_reminder/utils/show_dialog.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    setState(() {});
    await context.read<HomeProvider>().fetchReminders(false);
    isLoading = false;
    setState(() {});
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
        leading: IconButton(
          onPressed: () {
            if (ZoomDrawer.of(context)!.isOpen()) {
              ZoomDrawer.of(context)!.close();
            } else {
              ZoomDrawer.of(context)!.open();
            }
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        foregroundColor: Colors.white,
        title: Text(
          'Reminder',
          style: largetext.copyWith(
              color: Colors.white, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.all(10.r),
        child: isLoading
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
                              isLoading = true;
                              setState(() {});
                              showAlertDialog(
                                  navigatorKey.currentContext!,
                                  await context
                                      .read<HomeProvider>()
                                      .deleteReminder(context
                                          .read<HomeProvider>()
                                          .remindersList[index]),
                                  editOrAddReminder: true);
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
