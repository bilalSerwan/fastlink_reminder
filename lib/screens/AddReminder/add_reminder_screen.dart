// ignore_for_file: must_be_immutable

import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController titleController = TextEditingController();

  DateTime? selectedDate;

  Future<void> pickDate(BuildContext context) async {
    selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      initialDate: DateTime.now(),
    );
    setState(() {});
  }

  int numberOfReminders = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Reminder',
            style: Theme.of(context)
                .typography
                .englishLike
                .headlineMedium!
                .copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: true,
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomeTextField(
                    controller: titleController,
                    validatorFunction: (v) {
                      return null;
                    },
                    label: 'Reminder Title',
                    hintText: 'Enter Reminder Title',
                    prefixIcon: Icons.abc),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exparation Date',
                            style: Theme.of(context)
                                .typography
                                .dense
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                          ),
                          Text(selectedDate == null
                              ? ""
                              : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"),
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CupertinoButton(
                        color: Colors.pink,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Text('Pick Date'),
                        onPressed: () async {
                          await pickDate(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reminders',
                        style: Theme.of(context)
                            .typography
                            .englishLike
                            .bodyLarge!
                            .copyWith(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                      ),
                      InkWell(
                        onTap: () {
                          numberOfReminders++;
                          setState(() {});
                          print('button pressed=============');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.pink,
                          radius: 15,
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      for (int i = 0; i < numberOfReminders; i++)
                        Row(
                          children: [
                            Text('$i'),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
