// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'package:communication/Setting_view.dart';
import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/user/widgets/my_drawer_items.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.5,
      child: Drawer(
        child: Column(
          children: [
            //*============================================
            //* the first container that have image and name
            //*============================================
            Container(
              height: 30.h,
              color: AppColor.darkBlue,
              padding: EdgeInsets.only(top: 3.h, left: 3.h, right: 2.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingView(),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 30.sp,
                          backgroundImage: const NetworkImage(
                              "https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg"),
                        ),
                      ),
                      // const Spacer(),
                      IconButton(
                          onPressed: () {
                            print("Sunny");
                          },
                          icon: Icon(
                            Icons.wb_sunny_sharp,
                            color: AppColor.white,
                            size: 22.sp,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              text: "Osama Saleh",
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp),
                          MyText(
                              text: "+201096162372",
                              color: AppColor.white.withOpacity(.5),
                              fontSize: 12.sp),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            //*============================================
            //* items of drawer
            //*============================================
            Expanded(
              child: ListView(
                children: [
                  MyListTitle(
                      title: "New Group",
                      leading: Icon(
                        Icons.people_outline,
                        size: 20.sp,
                      )),
                  MyListTitle(
                      title: "Contact",
                      leading: Icon(
                        Icons.person_outline_outlined,
                        size: 20.sp,
                      )),
                  MyListTitle(
                      title: "Calls",
                      leading: Icon(
                        Icons.call_outlined,
                        size: 20.sp,
                      )),
                  MyListTitle(
                      title: "People Nearby",
                      leading: Icon(
                        Icons.nature_people_outlined,
                        size: 20.sp,
                      )),
                  MyListTitle(
                      title: "Saved Message",
                      leading: Icon(
                        Icons.bookmark_border,
                        size: 20.sp,
                      )),
                  MyListTitle(
                      title: "Settigs",
                      leading: Icon(
                        Icons.settings_outlined,
                        size: 20.sp,
                      )),
                  MyListTitle(
                      title: "Invite Friends",
                      leading: Icon(
                        Icons.person_add_alt_outlined,
                        size: 20.sp,
                      )),
                  MyListTitle(
                      title: "Telegram Features",
                      leading: Icon(
                        Icons.question_mark_outlined,
                        size: 20.sp,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
