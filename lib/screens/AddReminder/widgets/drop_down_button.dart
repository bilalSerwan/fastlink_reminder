// ignore_for_file: must_be_immutable

import 'package:fastlink_reminder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomeDropDown extends StatelessWidget {
  CustomeDropDown(
      {super.key, required this.selectedItem,required this.items, required this.label, this.onChaned});
  final List items;
  final String label;
  final void Function(dynamic)? onChaned;
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 130.w,
      initialSelection: selectedItem,
      menuHeight: 200.h,
      label: Text(label),
      dropdownMenuEntries:
          items.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
      onSelected: onChaned,
      menuStyle: MenuStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: primaryColor),
        ),
        constraints: BoxConstraints(maxHeight: 70.h, maxWidth: 150.w),
      ),
      textStyle: TextStyle(fontSize: 15.sp),
    );
  }
}
