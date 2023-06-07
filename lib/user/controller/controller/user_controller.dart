// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication/components/const.dart';
import 'package:communication/module/user_model.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  //*=============================================
  //?========= Get All user in application =======
  //*=============================================
  List<UserModel>? countUsers;
  Future getAllUser() async {
    
    countUsers = [];
    var value = await FirebaseFirestore.instance.collection('users').get();
    value.docs.forEach((element) {
      print(" element ${element.data()}");
      if (element.data()["token"] != MyConst.uidUser) {
        countUsers!.add(UserModel.fromJson(element.data()));
      }
    });
    
    print("countUsers : ${countUsers!.length}");
    notifyListeners();
  }
}
