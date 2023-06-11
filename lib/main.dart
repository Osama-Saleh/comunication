// ignore_for_file: unused_local_variable, avoid_print, depend_on_referenced_packages

import 'dart:io';

import 'package:communication/chatting/controller/chatting_controller.dart';
import 'package:communication/chatting/views/chatting_view.dart';
import 'package:communication/components/const.dart';
import 'package:communication/core/hive_helper.dart';
import 'package:communication/home/home_view.dart';
import 'package:communication/login/controller/provider/login_controller.dart';
import 'package:communication/register/controller/provider/register_controller.dart';
import 'package:communication/register/register_view.dart';
import 'package:communication/user/controller/controller/user_controller.dart';
import 'package:communication/user/user_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HiveHelper.hiveInit();

  Directory dir = await getApplicationDocumentsDirectory();
  await HiveHelper.openBox(boxName: "userData");

  MyConst.uidUser = HiveHelper.getData(key: "userId");
  print("uidUser ${MyConst.uidUser}");

  // MyConst.isMessaged = HiveHelper.getData(key: "isMessaged");
  // print("isMessaged ${MyConst.isMessaged}");

  Widget? firstScreen;
  if (MyConst.uidUser != null) {
    firstScreen = const HomeView();
  } else {
    firstScreen = const RegisterView();
  }

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(widget: firstScreen), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.widget});
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider<RegisterController>(
          create: (context) => RegisterController(),
        ),
        ChangeNotifierProvider<UserController>(
          create: (context) => UserController(),
        ),
        ChangeNotifierProvider<ChattingController>(
          create: (context) => ChattingController(),
        ),
      ],
      builder: (context, child) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              
              home: 
              widget,
              routes: {
                "/userView" :(context) => UserView()
              },
            );
          },
        );
      },
    );
  }
}
