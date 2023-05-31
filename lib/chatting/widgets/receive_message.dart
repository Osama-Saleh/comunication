// ignore_for_file: must_be_immutable

import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/module/message_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class ReceiveMessage extends StatelessWidget {
  ReceiveMessage({super.key, this.messageModel});
  MessageModel? messageModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  bottomStart: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: messageModel!.text != null ? MyText(
              text: "${messageModel!.text}",
              fontSize: 15.sp,
            ) : Image(image: NetworkImage("${messageModel!.image}"))
          ),
        ),
      ),
    );
  }
}
