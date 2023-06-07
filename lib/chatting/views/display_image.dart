// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:communication/chatting/model/message_model.dart';
import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_icon_button.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/module/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DisplayImage extends StatelessWidget {
   DisplayImage({super.key, this.messageModel, this.userModel});
   MessageModel? messageModel;
   UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.darkBlue,
        centerTitle: false,
        toolbarHeight: 10.h,
        title: 
        // Text("${userModel!.name}")
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              Container(
                height: 12.h,
                width: 12.w,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: userModel!.image == null
                    ? Center(
                        child: MyText(
                        text:
                            "${userModel!.name![0].toUpperCase()}${userModel!.name![1].toUpperCase()}",
                        color: AppColor.white,
                        fontSize: 12.sp,
                      ))
                    : Image(
                        image: NetworkImage(
                          "${userModel!.image}",
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                width: 3.w,
              ),
              MyText(
                text: "${userModel!.name}",
                fontSize: 15.sp,
              ),
            ],
          ),
        ),
        // leading: MyIconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //     //* wait for completing the state before navigating to another screen
        //     // SchedulerBinding.instance.addPostFrameCallback((_) {
        //     //   Navigator.pop(context);
        //     // });
        //   },
        //   icon: Icons.arrow_back,
        // ),
      ),
      body: Image(
        image: NetworkImage("${messageModel!.image}"),
        fit: BoxFit.fill,
        height: double.infinity,
      ),
    );
  }
}
