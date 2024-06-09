import 'package:fastlink_reminder/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAlertDialog(BuildContext context , String result){
  showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  padding: EdgeInsets.all(15.w),
                                  width: 0.9.sw,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.r))),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '$result',
                                        textAlign: TextAlign.center,
                                        style: subtitle.copyWith(
                                            decoration: TextDecoration.none),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
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