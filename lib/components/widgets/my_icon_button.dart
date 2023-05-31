import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    this.onPressed,
    this.icon,
  });
  final Function()? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {  
    return IconButton(
      
        onPressed: onPressed,
        
        icon: Icon(
          icon,
          size: 20.sp,
        ));
  }
}