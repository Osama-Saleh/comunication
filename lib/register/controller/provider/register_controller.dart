// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication/module/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  // GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
  //*                 Register user
  //*====================================================
  Future creatuser({
    required String? mail,
    required String? password,
    required String? name,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: mail!,
      password: password!,
    )
        .then((value) {
      saveUserDate(mail: mail, name: name, id: value.user!.uid);
      print("User Created ${value.user!.uid}");
    });

    notifyListeners();
  }

  //*=============================================
  //?========= save user data in firebase ========
  //*=============================================
  Future<void> saveUserDate({
    String? name,
    String? mail,
    String? id,
  }) async {
    // emit(SaveUserDataLoadingState());
    // print("SaveUserDataLoadingState");
    UserModel userModel = UserModel(name: name, mail: mail, token: id);
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userModel.toMap())
        .then((value) {
      // emit(SaveUserDataSuccessState());
      // print("SaveUserDataSuccessState");
    }).catchError((onError) {
      // emit(SaveUserDataErrorState());
      print("SaveUserDataError $onError");
    });
  }
}
