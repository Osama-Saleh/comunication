// ignore_for_file: sized_box_for_whitespace

import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_elevated_button.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/components/widgets/my_text_form_field.dart';
import 'package:communication/login/login_view.dart';
import 'package:communication/register/controller/provider/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var registerFormKey = GlobalKey<FormState>();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController mailController = TextEditingController();

  // TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var cubit = RegisterCubit.get(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 8.h, left: 5.h, right: 5.h),
        child: Form(
          key: registerFormKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Get Started",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 2.h,
                ),
                MyText(
                  text: "Create your account now",
                  fontSize: 15.sp,
                  color: AppColor.black.withOpacity(.5),
                ),
                SizedBox(
                  height: 5.h,
                ),
                MyText(
                  text: "Full name",
                  fontSize: 15.sp,
                  color: AppColor.black,
                ),
                SizedBox(
                  height: 1.h,
                ),
                MyTextFormField(
                  controller: context.read<RegisterController>().nameController,
                  hintText: "Enter Your Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "faild";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                MyText(
                  text: "Email",
                  fontSize: 15.sp,
                  color: AppColor.black,
                ),
                SizedBox(
                  height: 1.h,
                ),
                MyTextFormField(
                  controller: context.read<RegisterController>().mailController,
                  hintText: "Enter Your Mail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "faild";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                MyText(
                  text: "Password",
                  fontSize: 15.sp,
                  color: AppColor.black,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Consumer<RegisterController>(
                  builder: (context, registerController, child) {
                    return MyTextFormField(
                      controller:
                          context.read<RegisterController>().passwordController,
                      hintText: "Password",
                      obscureText: registerController.isVisibility,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            registerController.changeVisibilityPassword();
                          },
                          icon: registerController.prefixIcon),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "faild";
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Consumer<RegisterController>(
                  builder: (context, registerController, child) {
                    return Container(
                      width: double.infinity,
                      child: MyElevatedButton(
                        text: "Sign Up",
                        onPressed: () {
                          if (registerFormKey.currentState!.validate()) {}
                          registerController
                              .creatuser(
                            mail: registerController.mailController.text,
                            password:
                                registerController.passwordController.text,
                            name: registerController.nameController.text,
                          )
                              .whenComplete(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>const LoginView(),
                                ));
                          });
                        },
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "Have an account",
                      fontSize: 12.sp,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ));
                        },
                        child: MyText(
                          text: "Login",
                          fontSize: 12.sp,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
