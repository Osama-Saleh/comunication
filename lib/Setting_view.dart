// ignore_for_file: file_names, unnecessary_import, implementation_imports, prefer_const_constructors_in_immutables

import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_divider.dart';
import 'package:communication/components/widgets/my_icon_button.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/home/home_view.dart';
import 'package:communication/user/widgets/my_drawer_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:sizer/sizer.dart';

class SettingView extends StatefulWidget {
  SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  var top = 0.0;

  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                //*===================================================
                //*================   App Bar Flexible    ============
                //*===================================================
                SliverAppBar(
                  backgroundColor: AppColor.darkBlue,
                  expandedHeight: 200,
                  toolbarHeight: 8.h,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                        title: Row(
                          children: [
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: top <= 130 ? 1.0 : 0.0,
                              child: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg"),
                              ),
                            ),
                            MyText(
                              text: "Osama Saleh",
                              fontSize: 15.sp,
                            ),
                          ],
                        ),
                        centerTitle: false,
                        background: const Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg")),
                      );
                    },
                  ),
                  leading: MyIconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const HomeView(),
                      //     ));
                    },
                    icon: Icons.arrow_back,
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          size: 20.sp,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert_outlined,
                          size: 20.sp,
                        )),
                  ],
                ),
                SliverToBoxAdapter(
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //*====================================
                          //*========= items of Account =========
                          //*====================================
                          Padding(
                            padding: EdgeInsets.only(left: 3.h, bottom: 2.h),
                            child: MyText(
                              text: "Account",
                              fontSize: 14.sp,
                              color: AppColor.darkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "+201096162372",
                              subtitle: Text("Tap to change phone number",
                                  style: TextStyle(fontSize: 10.sp)),
                              subtitleSize: 12.sp,
                            ),
                          ),

                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "None",
                              subtitle: Text("Usedrname",
                                  style: TextStyle(fontSize: 10.sp)),
                              subtitleSize: 12.sp,
                            ),
                          ),

                          const MyDivider(),

                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Bio",
                              subtitle: Text("Add a few words about yourself",
                                  style: TextStyle(fontSize: 10.sp)),
                              subtitleSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          MyDivider(
                            thickness: 3.h,
                          ),
                          //*====================================
                          //*======= items of Settings  =========
                          //*====================================
                          Padding(
                            padding: EdgeInsets.only(
                                left: 3.h, bottom: 2.h, top: 3.h),
                            child: MyText(
                              text: "Settings",
                              fontSize: 14.sp,
                              color: AppColor.darkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Chat Settings",
                              leading: Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Privacy and Security",
                              leading: Icon(
                                Icons.lock_outline_rounded,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Notifications and Sounds",
                              leading: Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Data and Storage",
                              leading: Icon(
                                Icons.access_time,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Power Saving",
                              leading: Icon(
                                Icons.battery_charging_full_rounded,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Chat Folder",
                              leading: Icon(
                                Icons.folder_open,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Devices",
                              leading: Icon(
                                Icons.devices,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Language",
                              leading: Icon(
                                Icons.language,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Telegram Premium",
                              leading: Icon(
                                Icons.star_border_rounded,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          MyDivider(
                            thickness: 3.h,
                          ),
                          //*====================================
                          //*======= items of Help  =============
                          //*====================================
                          Padding(
                            padding: EdgeInsets.only(
                                left: 3.h, bottom: 2.h, top: 3.h),
                            child: MyText(
                              text: "Help",
                              fontSize: 14.sp,
                              color: AppColor.darkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Ask a Question",
                              leading: Icon(
                                Icons.chat_outlined,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Telegram FAQ",
                              leading: CircleAvatar(
                                backgroundColor: AppColor.black.withOpacity(.3),
                                radius: 12.sp,
                                child: CircleAvatar(
                                  backgroundColor: AppColor.white,
                                  radius: 10.5.sp,
                                  child: Icon(
                                    Icons.question_mark_rounded,
                                    color: AppColor.black.withOpacity(.6),
                                    size: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const MyDivider(),
                          InkWell(
                            onTap: () {},
                            child: MyListTitle(
                              title: "Privacy Policy",
                              leading: Icon(
                                Icons.privacy_tip_outlined,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            buildFAB()
          ],
        ));
  }

  Positioned buildFAB() {
    const double defaultMargin = 195;
    const double defaultStart = 230;
    const double defaultEnd = defaultStart / 2;

    double top = defaultMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset;
      if (offset < defaultMargin - defaultStart) {
        scale = 2.0;
      } else if (offset < defaultMargin - defaultEnd) {
        scale = (defaultMargin - defaultEnd - offset) / defaultEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 1.h,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.photo_camera),
        ),
      ),
    );
  }
}
