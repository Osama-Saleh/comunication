// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/components/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


TextEditingController fNameController = TextEditingController();
TextEditingController lNameController = TextEditingController();
var formKey = GlobalKey<FormState>();

Future<dynamic> myShowModealBottomSheet(BuildContext context, {var key}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(3.h),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "New Contact",
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyTextFormField(
                      controller: fNameController,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.sp)),
                      labelText: "First name (required)",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Faild";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyTextFormField(
                      controller: lNameController,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.sp)),
                      labelText: "Last name (optional)",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Faild";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyTextFormField(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.sp)),
                      labelText: "Phone number",
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.h,
                      child: ElevatedButton(
                          onPressed: () {
                            // if (formKey.currentState!.validate()) {
                            //   HomeCubit.get(context)
                            //       .addName(fNameController.text,lNameController.text)
                            //       .then((value) {
                            //     HomeCubit.get(context).insertItems(key: key,fName: fNameController.text,lName: lNameController.text);
                            //     Navigator.pop(context);
                            //   });

                            //   print(
                            //       "Done : ${HomeCubit.get(context).userModel!.fName}");
                            // }
                          },
                          child: MyText(
                            text: "Create Contact",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
