import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    this.onPressed,
    this.icon,
    this.color,
    this.size
  });
  final Function()? onPressed;
  final IconData? icon;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: size ?? 20.sp,
          color: color,
        ));
  }
}
