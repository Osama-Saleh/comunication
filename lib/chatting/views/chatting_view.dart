// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_is_empty, avoid_print, sized_box_for_whitespace, curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:communication/chatting/controller/chatting_controller.dart';
import 'package:communication/chatting/widgets/my_message.dart';
import 'package:communication/chatting/widgets/receive_message.dart';
import 'package:communication/components/app_colors.dart';
import 'package:communication/components/const.dart';
import 'package:communication/components/widgets/my_icon_button.dart';
import 'package:communication/components/widgets/my_text.dart';
// import 'package:communication/core/hive_helper.dart';
import 'package:communication/home/home_view.dart';
import 'package:communication/module/user_model.dart';
import 'package:communication/user/controller/controller/user_controller.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChattingView extends StatefulWidget {
  ChattingView({super.key, this.model});
  final UserModel? model;

  @override
  State<ChattingView> createState() => _ChattingState();
}

class _ChattingState extends State<ChattingView> {
  ScrollController scrollController = ScrollController();
  bool isIconVisible = false;
  @override
  void initState() {
    super.initState();
    Provider.of<ChattingController>(context, listen: false).initRecorder();
    Provider.of<ChattingController>(context, listen: false)
        .getMessage(receiverId: "${widget.model!.token}");

    // Provider.of<ChattingController>(context, listen: false)
    //     .
    scrollController.addListener(() {
      if (scrollController.offset >=scrollController.position.maxScrollExtent) {
        //* Scrolled to the bottom
        isIconVisible = false;
        print("Last");
        setState(() {});
      } else {
        //* Scrolled within the list
        isIconVisible = true;
        print("not Last");
        setState(() {});
      }
      // Provider.of<ChattingController>(context, listen: false).scrollListener();
    });
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        // Provider.of<ChattingController>(context,listen: false).scrollToLastListView();
        // Provider.of<ChattingController>(context, listen: false)
        //     .
        scrollController.animateTo(
            // Provider.of<ChattingController>(context, listen: false)
            // .
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn);
      },
    );
    // }
  }

  // ScrollController scrollController = ScrollController();
  // @override
  // void dispose() {
  //   // TODO: implement dispose

  //   // if (mounted) {
  //   //   Provider.of<ChattingController>(context, listen: false)
  //   //       .scrollController
  //   //       .dispose();
  //   // }

  //   if (mounted) {
  //     SchedulerBinding.instance.addPostFrameCallback((_) {
  //       Provider.of<ChattingController>(context).scrollController.dispose();
  //     });
  //   }
  //   super.dispose();
  // }

  // @override
  // void didChangeDependencies() {
  //   if (mounted) {
  //     SchedulerBinding.instance.addPostFrameCallback((_) {
  //       Provider.of<ChattingController>(context, listen: false)
  //           .scrollController;
  //     });
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    var providerListenFalse =
        Provider.of<ChattingController>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColor.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColor.darkBlue,
        centerTitle: false,
        toolbarHeight: 10.h,
        title: Row(
          children: [
            Container(
              height: 12.h,
              width: 12.w,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: widget.model!.image == null
                  ? Center(
                      child: MyText(
                      text:
                          "${widget.model!.name![0].toUpperCase()}${widget.model!.name![1].toUpperCase()}",
                      color: AppColor.white,
                      fontSize: 12.sp,
                    ))
                  : Image(
                      image: NetworkImage(
                        "${widget.model!.image}",
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              width: 3.w,
            ),
            MyText(
              text: "${widget.model!.name}",
              fontSize: 15.sp,
            ),
          ],
        ),
        leading: MyIconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: Icons.arrow_back,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*=========================================================
          //*                  display List of message
          //*=========================================================
          Expanded(
              child: providerListenFalse.messageLoaded == false
                  ? const Center(child: CircularProgressIndicator())
                  : (providerListenFalse.messageLoaded == true &&
                          providerListenFalse.messages!.isEmpty)
                      ? Center(
                          child: MyText(
                            text: "Say Hello 👋",
                            fontSize: 20.sp,
                          ),
                        )
                      : Stack(
                          children: [
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                                controller: scrollController,
                                // providerListenFalse.scrollController ,

                                itemBuilder: (context, index) {
                                  if (MyConst.uidUser ==
                                      providerListenFalse
                                          .messages![index].senderId) {
                                    //* My message
                                    return MyMessage(
                                      messageModel:
                                          providerListenFalse.messages![index],
                                      userModel: widget.model,
                                      // index: index,
                                      // fileName: cubit.fileName![index],
                                    );
                                  }
                                  return
                                      //* receive message
                                      ReceiveMessage(
                                    messageModel:
                                        providerListenFalse.messages![index],
                                    index: index,
                                  );
                                },
                                
                                itemCount:
                                    providerListenFalse.messages!.length),
                            Positioned(
                              bottom: 2.h,
                              right: 3.w,
                              child: Visibility(
                                visible: isIconVisible,
                                child: InkWell(
                                  onTap: () {
                                    Future.delayed(
                                      const Duration(milliseconds: 1000),
                                      () {
                                        // providerListenFalse.
                                        scrollController.animateTo(
                                            // providerListenFalse
                                            scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 100),
                                            curve: Curves.easeIn);
                                      },
                                    );

                                    print("Scrolled");
                                  },
                                  child: Container(
                                    width: 12.w,
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: MyIconButton(
                                        icon: Icons.keyboard_arrow_down_sharp,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )

              // FutureBuilder(
              //     future: getDate,
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.done &&
              //           Provider.of<ChattingController>(context, listen: false)
              //               .messages!
              //               .isEmpty) {
              //         return Center(
              //           child: MyText(
              //             text: "Say Hello 👋",
              //             fontSize: 20.sp,
              //           ),
              //         );
              //       } else if (snapshot.connectionState ==
              //               ConnectionState.done &&
              //           Provider.of<ChattingController>(context, listen: false)
              //               .messages!
              //               .isNotEmpty) {
              //         return ListView.separated(
              //             controller: providerListenFalse.scrollController,
              //             itemBuilder: (context, index) {
              //               if (MyConst.uidUser ==
              //                   providerListenFalse.messages![index].senderId) {
              //                 //* My message
              //                 return MyMessage(
              //                   messageModel:
              //                       providerListenFalse.messages![index],
              //                   index: index,
              //                   // fileName: cubit.fileName![index],
              //                 );
              //               }
              //               return
              //                   //* receive message
              //                   ReceiveMessage(
              //                 messageModel:
              //                     providerListenFalse.messages![index],
              //               );
              //             },
              //             separatorBuilder: (context, index) => SizedBox(
              //                   height: 5.h,
              //                 ),
              //             itemCount: providerListenFalse.messages!.length);
              //       } else {
              //         return const Center(child: CircularProgressIndicator());
              //       }
              //     }),
              ),
          //*========================================================
          //*           text Form Field to write my message
          //*========================================================
          Form(
            key: Provider.of<ChattingController>(
              context,
            ).formKey,
            child: Container(
                color: AppColor.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller:
                                  Provider.of<ChattingController>(context)
                                      .messageController,
                              minLines: 1,
                              maxLines: 5,
                              onTap: () {
                                providerListenFalse.isEmojiSelected = false;
                                print(
                                    "${widget.model!.token == MyConst.uidUser}");
                                print("emoji");
                              },
                              onChanged: (value) {
                                providerListenFalse.textEditController();
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(fontSize: 15.sp),
                                hintText: Provider.of<ChattingController>(
                                            context)
                                        .isChangeHintText
                                    ? "${Provider.of<ChattingController>(context).minutesTime}:${Provider.of<ChattingController>(context).secondTime}"
                                    : "Message",
                                hintStyle: TextStyle(fontSize: 15.sp),
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      // Provider.of<ChattingController>(context,
                                      //         listen: false)
                                      //     .selectEmoji();
                                      print(
                                          "${Provider.of<ChattingController>(context, listen: false).isEmojiSelected}");
                                      //!========================================== send voice
                                      if (Provider.of<ChattingController>(
                                                  context,
                                                  listen: false)
                                              .isChangeHintText ==
                                          true) {
                                        print("closed");
                                      } else {
                                        Provider.of<ChattingController>(context,
                                                listen: false)
                                            .selectEmoji();
                                      }

                                      //*===========================================
                                      //* hide keyboardType when click in emoji icon
                                      //*===========================================
                                      SystemChannels.textInput
                                          .invokeMethod("TextInput.hide");
                                    },
                                    icon: Provider.of<ChattingController>(
                                                context,
                                                listen: false)
                                            .isChangeHintText
                                        ? const Icon(Icons.close)
                                        : const Icon(
                                            Icons.emoji_emotions_outlined)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(3.h),
                              ),
                              keyboardType: TextInputType.multiline),
                        ),
                        //* icon button send

                        MyIconButton(
                          onPressed: (Provider.of<ChattingController>(context,
                                          listen: true)
                                      .messageController
                                      .text
                                      .trim()
                                      .isEmpty &&
                                  !Provider.of<ChattingController>(context,
                                          listen: false)
                                      .isChangeHintText)
                              ? null
                              : () {
                                  print(
                                      "messageController : ${providerListenFalse.messageController.text} ");

                                  if (providerListenFalse.isChangeHintText ==
                                      true) {
                                    print("isChangeHintText");

                                    print(
                                        "MessageConstroller after send record ${providerListenFalse.messageController.text}");
                                    providerListenFalse
                                        .stop(receiverId: widget.model!.token)
                                        .whenComplete(() async {
                                      await providerListenFalse.resetRecord();

                                      print(
                                          "secondTime ${providerListenFalse.secondTime} minutesTime ${providerListenFalse.minutesTime}");
                                    });
                                  } else {
                                    print("isChangeHintText2");
                                    providerListenFalse
                                        .sendMessage(
                                      receiverId: widget.model!.token,
                                      dateTime: DateTime.now().toString(),
                                      text: Provider.of<ChattingController>(
                                              context,
                                              listen: false)
                                          .messageController
                                          .text,
                                    )
                                        .whenComplete(() {
                                      providerListenFalse.hintText = "message";
                                      providerListenFalse
                                          .messageController.text = "";
                                      providerListenFalse
                                          .getMessage(
                                              receiverId: widget.model!.token)
                                          .whenComplete(() {
                                        if (providerListenFalse.messages !=
                                            null) {
                                          Future.delayed(
                                            const Duration(milliseconds: 1000),
                                            () {
                                              // providerListenFalse
                                              //     .
                                              scrollController.animateTo(
                                                  // Provider.of<ChattingController>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .
                                                  scrollController
                                                      .position.maxScrollExtent,
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  curve: Curves.easeIn);
                                            },
                                          );
                                          print("MaxScroll");
                                        }
                                      });
                                    });
                                  }
                                },
                          icon: Icons.send,
                        ),
                        // MyIconButton(
                        //     onPressed: () {
                        //       Provider.of<ChattingController>(context)
                        //           .selectDocuments(
                        //               receiverId: widget.model!.token);
                        //     },
                        //     icon: Icons.attach_file_sharp),
                        InkWell(
                          onLongPress: () async {
                            if (providerListenFalse.isMice == true) {
                              print("isMice");
                              providerListenFalse.record().whenComplete(() {
                                print("Recording");
                                providerListenFalse.timeRecord();
                                //!----------------------------------------------;
                              });
                              print("long");
                              providerListenFalse.isChangeHintText = true;
                              print(
                                  "isRecorderReady : ${Provider.of<ChattingController>(context, listen: false).isRecorderReady}");
                            } else {
                              providerListenFalse.setSelectImage(
                                  receiverId: widget.model!.token);
                            }
                          },
                          //* icon button to change between (mic - image) icons
                          child: MyIconButton(
                            onPressed: () {
                              providerListenFalse.changeMice();
                            },
                            icon:
                                Provider.of<ChattingController>(context).isMice
                                    ? Icons.mic_none_rounded
                                    : Icons.image_outlined,
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
          //* Special to emoji
          if (Provider.of<ChattingController>(context, listen: false)
                  .isEmojiSelected ==
              true)
            Expanded(
              child: EmojiPicker(
                textEditingController: providerListenFalse.messageController,
                onEmojiSelected: (category, emoji) {
                  providerListenFalse.textEditController();
                },
              ),
            )
        ],
      ),
    );
  }
}
