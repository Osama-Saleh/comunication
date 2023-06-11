// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyListTitle extends StatelessWidget {
  const MyListTitle({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    // this.titleSize,
    this.subtitleSize,
  });
  final String? title;
  final Widget? subtitle;
  final Widget? leading;
  // final double? titleSize;
  final double? subtitleSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 10.h,
          child: ListTile(
            title: Text(
              title!,
              style: TextStyle(fontSize: 13.sp),
            ),
            subtitle: subtitle,
            leading: leading,
          ),
        ),
      ],
    );
  }
}
