// ignore_for_file: must_be_immutable

import 'package:communication/components/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyElevatedButton extends StatelessWidget {
   MyElevatedButton({
    super.key,
    this.text,
    this.onPressed,
    this.onLongPress,
    this.border
  });
  final String? text;
  final Function()? onPressed;
  final Function()? onLongPress;
   double? border;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border??0),
        )),
        child: MyText(
          text: text,
          fontSize: 15.sp,
        ));
  }
}
