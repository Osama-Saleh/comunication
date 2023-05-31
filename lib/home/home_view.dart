// ignore_for_file: avoid_print

import 'package:communication/add_user/add_user.dart';
import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_show_model.dart';
import 'package:communication/user/user_view.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<AnimatedListState> animatedKey = GlobalKey();

  bool? isLast = false;
  var pageController = PageController();
  // UserModel? userModel = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          if (value == 1) {
            print(value);
            setState(() {
              isLast = true;
            });
          } else {
            setState(() {
              isLast = false;
            });
          }
          print(isLast);
        },
        children: const [UserView(), AddUser()],
      ),
      //*=============================================
      //* Floating Action Button
      //*=============================================
      floatingActionButton: SizedBox(
        height: 9.h,
        width: 12.w,
        child: FloatingActionButton(
            backgroundColor: AppColor.darkBlue,
            onPressed: () {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              if (isLast!) {
                print("object");
                myShowModealBottomSheet(context);
              }
            },
            shape: const BeveledRectangleBorder(),
            child: isLast == true
                ? Icon(
                    Icons.person_add_alt_1,
                    size: 20.sp,
                  )
                : Icon(
                    Icons.edit,
                    size: 20.sp,
                  )),
      ),
    );
  }
}
