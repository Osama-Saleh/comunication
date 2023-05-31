// ignore_for_file: avoid_print

import 'package:communication/components/const.dart';
import 'package:communication/core/hive_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //*====================================================
  //*                 visibiluty password
  //*====================================================
  bool isVisibility = true;
  Icon prefixIcon = const Icon(Icons.visibility_off);
  void changeVisibilityPassword() {
    isVisibility = !isVisibility;

    if (isVisibility) {
      prefixIcon = const Icon(Icons.visibility_off);
    } else {
      prefixIcon = const Icon(Icons.visibility);
    }
    print(isVisibility);
    notifyListeners();
  }

  //*====================================================
  //*                 Signin User
  //*====================================================
  Future singIn({
    required String? mail,
    required String? password,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail!, password: password!)
        .then((value) {
      print("get user Id1 ${value.user!.uid}");
      // HiveHelper.openBox(boxName: "userData");
      
      HiveHelper.setData(key: "userId", value: value.user!.uid)
          .whenComplete(() {
        print("get user Id11 ${value.user!.uid}");
        MyConst.uidUser = HiveHelper.getData(key: "userId");
        print("MyConst.uidUser  ${MyConst.uidUser }");
      });
      print("credential singIn ${value.user!.uid}");
    });
    notifyListeners();
  }
}
