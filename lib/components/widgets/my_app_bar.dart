// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:telegram/components/app_colors.dart';
// import 'package:telegram/widgets/my_text.dart';

// ignore_for_file: non_constant_identifier_names

import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


AppBar MyAppBar(
    {String? title,
    Function()? onPressed1,
    Function()? onPressed2,
    IconData? icon1,
    IconData? icon2,
    Widget? leading}) {
  return AppBar(
    backgroundColor: AppColor.darkBlue,
    toolbarHeight: 8.h,
    title: Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: MyText(  
        text: title,
        fontSize: 18.sp,
      ),
    ),
    centerTitle: false,
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 2.h),
        child: IconButton(
            onPressed: onPressed1,
            icon: Icon(
              icon1,
              color: AppColor.white,
              size: 22.sp,
            )),
      ),
      if (icon2 != null)
        Padding(
          padding: EdgeInsets.only(right: 2.h),
          child: IconButton(
              onPressed: onPressed2,
              icon: Icon(
                icon2,
                color: AppColor.white,
                size: 22.sp,
              )),
        )
    ],
    leading: leading,
  );
}




// final String? title;
//   final Function()? onPressed1;
//   final Function()? onPressed2;
//   final IconData? icon1;
//   final IconData? icon2;
//   final Widget? leading;

// class MyAppBar extends StatelessWidget implements  PreferredSizeWidget {
//   const MyAppBar(
//       {super.key,
//       this.title,
//       this.onPressed1,
//       this.onPressed2,
//       this.icon1,
//       this.icon2,
//       this.leading,
//       });
//   final String? title;
//   final Function()? onPressed1;
//   final Function()? onPressed2;
//   final IconData? icon1;
//   final IconData? icon2;
//   final Widget? leading;

//   @override
//   Widget build(BuildContext context) {
//     return 
//     AppBar(
//       backgroundColor: AppColor.darkBlue,
//       toolbarHeight: 8.h,
      
//       title: Padding(
//         padding:  EdgeInsets.only(left: 2.h),
//         child: MyText(
//           text: title,
//           fontSize: 18.sp,
//         ),
//       ),
//       centerTitle: false,
//       actions: [
//         IconButton(
//             onPressed: onPressed1,
//             icon: Icon(
//               icon1,
//               color: AppColor.white,
//               size: 22.sp,
//             )),
//         if (icon2 != null)
//           IconButton(
//               onPressed: onPressed2,
//               icon: Icon(
//                 icon2,
//                 color: AppColor.white,
//                 size: 22.sp,
//               ))
//       ],
      
//       leading: leading,
//     );
//   }
  
  

//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => Size.fromHeight(10.h);
// }
