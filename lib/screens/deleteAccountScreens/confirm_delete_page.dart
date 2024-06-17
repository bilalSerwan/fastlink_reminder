import 'package:fastlink_reminder/Provider/auth_provider.dart';
import 'package:fastlink_reminder/screens/Auth/sign_in_screen.dart';
import 'package:fastlink_reminder/screens/drawer_screen.dart';
import 'package:fastlink_reminder/utils/loading_dialog.dart';
import 'package:fastlink_reminder/utils/text_field.dart';
import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ConfirmDeletePage extends StatefulWidget {
  const ConfirmDeletePage({super.key, required this.text});
  final String text;

  @override
  State<ConfirmDeletePage> createState() => _ConfirmDeletePageState();
}

class _ConfirmDeletePageState extends State<ConfirmDeletePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DrawerScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 75.h,
              ),
              CircleAvatar(
                radius: 70.r,
                backgroundColor: Colors.red,
                child: Center(
                  child: Icon(
                    Icons.delete,
                    size: 75.r,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Delete Account',
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(widget.text),
              SizedBox(
                height: 10.h,
              ),
              CustomeTextField(
                  controller: textController,
                  validatorFunction: (v) {
                    return null;
                  },
                  label: 'Confirm Code',
                  hintText: 'Enter Confirmation Code',
                  prefixIcon: const SizedBox()),
              SizedBox(
                height: 10.h,
              ),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                ),
                onPressed: () async {
                  showLoadiongDialog(context);
                  final result = await context
                      .read<AuthProvider>()
                      .confirmDestroyAccount(textController.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(15.w),
                              width: 0.9.sw,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    result,
                                    textAlign: TextAlign.center,
                                    style: subtitle.copyWith(
                                        decoration: TextDecoration.none),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInScreen()),
                                          (route) => false);
                                    },
                                    child: const Text('OK'),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
                child: Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
