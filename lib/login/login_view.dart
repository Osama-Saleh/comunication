import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_elevated_button.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/components/widgets/my_text_form_field.dart';
import 'package:communication/home/home_view.dart';
import 'package:communication/login/controller/provider/login_controller.dart';
import 'package:communication/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: Form(
          key: loginFormKey,
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: MyText(
                      text: "Login",
                      fontSize: 35.sp,
                      color: AppColor.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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
                    controller: context.read<LoginController>().mailController,
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
                  Consumer<LoginController>(
                    builder: (context, logincontroller, child) {
                      return MyTextFormField(
                        controller:
                            context.read<LoginController>().passwordController,
                        hintText: "Password",
                        obscureText: logincontroller.isVisibility,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            logincontroller.changeVisibilityPassword();
                          },
                          icon: logincontroller.prefixIcon,
                        ),
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
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Consumer<LoginController>(
                      builder: (context, loginController, child) {
                        return SizedBox(
                          width: 30.w,
                          height: 8.h,
                          child: MyElevatedButton(
                            text: "Log In",
                            border: 10,
                            onPressed: () {
                              if (loginFormKey.currentState!.validate()) {
                                loginController
                                    .singIn(
                                        mail:
                                            loginController.mailController.text,
                                        password: loginController
                                            .passwordController.text)
                                    .whenComplete(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomeView(),
                                      ));
                                });
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterView(),
                              ));
                        },
                        child: const Text("Register Now")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
