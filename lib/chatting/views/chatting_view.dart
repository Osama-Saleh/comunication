// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_is_empty, avoid_print, sized_box_for_whitespace

import 'dart:async';

import 'package:communication/chatting/controller/chatting_controller.dart';
import 'package:communication/chatting/widgets/my_message.dart';
import 'package:communication/chatting/widgets/receive_message.dart';
import 'package:communication/components/app_colors.dart';
import 'package:communication/components/const.dart';
import 'package:communication/components/widgets/my_icon_button.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/core/hive_helper.dart';
import 'package:communication/home/home_view.dart';
import 'package:communication/module/user_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
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
  // TextEditingController messageController = TextEditingController();
  // ScrollController scrollController = ScrollController();
  // var formKey = GlobalKey<FormState>();
  // bool isMice = false;
  // String? hintText = "Message";
  // int? num = 0;
  //!==============================================
  // FlutterSoundRecorder? myRecord;
  // final audioPlayer = AssetsAudioPlayer();
  // String? filePath;
  // bool? play = false;
  // String? recordText = "00:00:00";

  // void startIt() async {
  //   filePath = "/sdcard/Download/temp.wav";
  //   myRecord = FlutterSoundRecorder();
  //   // await myRecord!
  // }
  // Future? getData;
  @override
  void initState() {
    super.initState();
    // Provider.of<ChattingController>(context).initRecorder();
    Provider.of<ChattingController>(context, listen: false)
        .getMessage(receiverId: "${widget.model!.token}");
    // getData =
    // Provider.of<ChattingController>(context).getMessage(receiverId: widget.model!.token);
    // if (Provider.of<ChattingController>(context).messages == null) {
    //   Future.delayed(const Duration(milliseconds: 500), () {
    //     scrollController.animateTo(scrollController.position.maxScrollExtent,
    //         duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    //   });
    // }
  }
  // ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // var cubit = Provider.of<ChattingController>(context);
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
              // SchedulerBinding.instance.addPostFrameCallback((_) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (__) => const HomeView(),
              //     ));
              // });
              // Navigator.pushReplacementNamed(context, "/homeView");

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  )).whenComplete(() {
                // Provider.of<ChattingController>(context).recorder.closeRecorder();
              });
            },
            icon: Icons.arrow_back,
          ),
        ),
        body:
            // Provider.of<ChattingController>(context).messages!.isEmpty
            // ? Center(
            //     child: MyText(
            //       text: "Say Hello 👋",
            //       fontSize: 20.sp,
            //     ),
            //   )
            // :
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //*=========================================================
            //*                   List of message
            //*=========================================================
            // Expanded(
            //   child: Center(
            //     child: MyText(
            //       text: "Say Hello 👋",
            //       fontSize: 20.sp,
            //     ),
            //   ),
            // ),
            Expanded(
                child:
                 Provider.of<ChattingController>(context, listen: false)
                        .messages!
                        .isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        controller: Provider.of<ChattingController>(context,
                                listen: false)
                            .scrollController,
                        itemBuilder: (context, index) {
                          if (MyConst.uidUser ==
                              Provider.of<ChattingController>(context,
                                      listen: false)
                                  .messages![index]
                                  .senderId) {
                            //* My message

                            return MyMessage(
                              messageModel: Provider.of<ChattingController>(
                                      context,
                                      listen: false)
                                  .messages![index],
                              index: index,
                              // fileName: cubit.fileName![index],
                            );
                          }
                          return

                              //* receive message
                              ReceiveMessage(
                            messageModel: Provider.of<ChattingController>(
                                    context,
                                    listen: false)
                                .messages![index],
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 5.h,
                            ),
                        itemCount: Provider.of<ChattingController>(context)
                            .messages!
                            .length)),
            //*========================================================
            //*                 input my message

            //*========================================================
            // Container(
            //   child: Text("${cubit.minutesTime}:${cubit.secondTime}"),
            // ),

            Form(
              key: Provider.of<ChattingController>(context).formKey,
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
                                  Provider.of<ChattingController>(context,
                                          listen: false)
                                      .isEmojiSelected = false;

                                  print("emoji");
                                },
                                onChanged: (value) {
                                  Provider.of<ChattingController>(context,
                                          listen: false)
                                      .textEditController();
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
                                          // cubit
                                          //     .stop(
                                          //         receiverId:
                                          //             widget.model!.token)
                                          //     .whenComplete(() {
                                          //   cubit.isChangeHintText = false;
                                          //   cubit.hintText = "Message";
                                          //   print("cubit.changeHintText");
                                          // });
                                        } else {
                                          Provider.of<ChattingController>(
                                                  context,
                                                  listen: false)
                                              .selectEmoji();
                                        }

                                        //*===========================================
                                        //* hide keyboardType when click in emoji icon
                                        //*===========================================
                                        SystemChannels.textInput
                                            .invokeMethod("TextInput.hide");
                                        // print(
                                        //     "isEmoji ${cubit.isEmojiSelected}");
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
                          MyIconButton(
                            onPressed: (Provider.of<ChattingController>(context)
                                        .messageController
                                        .text
                                        .trim()
                                        .isEmpty &&
                                    (Provider.of<ChattingController>(context)
                                                .secondTime! +
                                            Provider.of<ChattingController>(
                                                    context)
                                                .minutesTime!) ==
                                        0)
                                ? null
                                : () {
                                    print(
                                        "messageController : ${Provider.of<ChattingController>(context, listen: false).messageController.text}");
                                    if (Provider.of<ChattingController>(context,
                                                listen: false)
                                            .isChangeHintText ==
                                        true) {
                                        Provider.of<ChattingController>(context,
                                              listen: false)
                                          .stop(receiverId: widget.model!.token)
                                          .whenComplete(() {
                                        Provider.of<ChattingController>(context,
                                                listen: false)
                                            .isChangeHintText = false;
                                        Provider.of<ChattingController>(context,
                                                listen: false)
                                            .hintText = "Message";
                                        print("cubit.changeHintText");
                                      });
                                    } else {
                                      Provider.of<ChattingController>(context,
                                              listen: false)
                                          .sendMessage(
                                        receiverId: widget.model!.token,
                                        dateTime: DateTime.now().toString(),
                                        text: Provider.of<ChattingController>(
                                                context,
                                                listen: false)
                                            .messageController
                                            .text,
                                        // image: cubit.selectImage.toString(),
                                        // record: cubit.audioUrl,
                                      )
                                          .whenComplete(() {
                                        Provider.of<ChattingController>(context,
                                                listen: false)
                                            .hintText = "message";
                                        Provider.of<ChattingController>(context,
                                                listen: false)
                                            .messageController
                                            .text = "";
                                        Provider.of<ChattingController>(context,
                                                listen: false)
                                            .getMessage(
                                                receiverId: widget.model!.token)
                                            .whenComplete(() {
                                          HiveHelper.setData(
                                              key: "isMessaged",
                                              value: "true");
                                          if (Provider.of<ChattingController>(
                                                      context,
                                                      listen: false)
                                                  .messages !=
                                              null) {
                                            Future.delayed(
                                              const Duration(
                                                  milliseconds: 1000),
                                              () {
                                                Provider.of<ChattingController>(
                                                        context,
                                                        listen: false)
                                                    .scrollController
                                                    .animateTo(
                                                        Provider.of<ChattingController>(
                                                                context,
                                                                listen: false)
                                                            .scrollController
                                                            .position
                                                            .maxScrollExtent,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    100),
                                                        curve: Curves.easeIn);
                                              },
                                            );
                                            print("MaxScroll");
                                            // print("MaxScroll ${cubit.messages![0].record}");
                                          }
                                        });
                                      });
                                    }
                                  },
                            icon: Icons.send,
                          ),
                          MyIconButton(
                              onPressed: () {
                                Provider.of<ChattingController>(context)
                                    .selectDocuments(
                                        receiverId: widget.model!.token);
                              },
                              icon: Icons.attach_file_sharp),
                          InkWell(
                            onLongPress: () async {
                              if (Provider.of<ChattingController>(context,
                                          listen: false)
                                      .isMice ==
                                  true) {
                                Provider.of<ChattingController>(context,
                                        listen: false)
                                    .record()
                                    .whenComplete(() {
                                  print("Recorder");
                                  Provider.of<ChattingController>(context,
                                          listen: false)
                                      .timeRecord();
                                  //!----------------------------------------------;
                                });
                                print("long");
                                // cubit.hintText = "${cubit.minutesTime} : ${cubit.secondTime}";
                                Provider.of<ChattingController>(context,
                                        listen: false)
                                    .isChangeHintText = true;
                                print(
                                    "isRecorderReady : ${Provider.of<ChattingController>(context, listen: false).isRecorderReady}");
                              } else {
                                Provider.of<ChattingController>(context,
                                        listen: false)
                                    .setSelectImage(
                                        receiverId: widget.model!.token);
                              }
                            },
                            child: MyIconButton(
                              onPressed: () {
                                Provider.of<ChattingController>(context,
                                        listen: false)
                                    .changeMice();
                              },
                              icon: Provider.of<ChattingController>(context)
                                      .isMice
                                  ? Icons.mic_none_rounded
                                  : Icons.image_outlined,
                            ),
                          )
                        ],
                      ),
                      if (Provider.of<ChattingController>(context,
                                  listen: false)
                              .isEmojiSelected ==
                          true)
                        Container(
                          height: 30.h,
                          width: double.infinity,
                          child: EmojiPicker(
                            textEditingController:
                                Provider.of<ChattingController>(context,
                                        listen: false)
                                    .messageController,
                            onEmojiSelected: (category, emoji) {
                              Provider.of<ChattingController>(context,
                                      listen: false)
                                  .textEditController();
                            },
                          ),
                        )
                    ],
                  )),
            ),
          ],
        ));
  }
}
