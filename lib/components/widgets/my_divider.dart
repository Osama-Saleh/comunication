import 'package:communication/components/app_colors.dart';
import 'package:flutter/material.dart';


class MyDivider extends StatelessWidget {
  const MyDivider({super.key, this.indent,this.thickness});
  final double? indent;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColor.black.withOpacity(.3),
      indent: indent  ,
      thickness:thickness ,
    );
  }
} 
