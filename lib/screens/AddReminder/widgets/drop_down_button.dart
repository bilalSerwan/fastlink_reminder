// ignore_for_file: must_be_immutable

import 'package:fastlink_reminder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeDropDownButton extends StatefulWidget {
  CustomeDropDownButton({super.key, required this.items, this.selectedValue});
  final List items;
  String? selectedValue;
  @override
  State<CustomeDropDownButton> createState() => _CustomeDropDownButtonState();
}

class _CustomeDropDownButtonState extends State<CustomeDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(15),
      ),
      width: 150.w,
      height: 50.h,
      child: Center(
        child: DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          padding: EdgeInsets.all(5.w),
          items: widget.items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (v) {
            setState(() {
              widget.selectedValue = v!.toString();
            });
          },
          value: widget.selectedValue,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

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
