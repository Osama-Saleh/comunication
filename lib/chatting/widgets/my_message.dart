// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print, unnecessary_import, sized_box_for_whitespace

import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:communication/chatting/controller/chatting_controller.dart';
import 'package:communication/chatting/model/message_model.dart';
import 'package:communication/chatting/views/chatting_view.dart';
import 'package:communication/chatting/views/display_image.dart';
import 'package:communication/components/app_colors.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:communication/home/home_view.dart';
import 'package:communication/module/user_model.dart';
import 'package:communication/user/controller/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyMessage extends StatefulWidget {
  MyMessage({
    super.key,
    this.index,
    this.messageModel,
    this.userModel,
  });
  int? index;
  MessageModel? messageModel;
  UserModel? userModel;
  // String? fileName;

  @override
  State<MyMessage> createState() => _MyMessageState();
}

class _MyMessageState extends State<MyMessage> {
  final audioPlayer = AudioPlayer();

  bool isPlay = false;

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  String formatTimeHour(int seconds) {
    return "${Duration(seconds: seconds)}".split(".")[0].padRight(6, "8");
  }

  String transformString(int seconds) {
    String minuteString =
        "${(seconds/60).floor() < 10 ? 0 : ""}${(seconds / 60).floor()}";
    String secondString = "${seconds % 60 < 10 ? 0 : ""}${seconds % 60}";
    return "$minuteString : $secondString";
  }

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlay = state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.h, top: 2.h),
      child: Align(
          alignment: AlignmentDirectional.topEnd,
          child: widget.messageModel!.text != null ||
                  widget.messageModel!.docsUrl != null
              //* spicail to duc
              ? Container(
                  margin: EdgeInsets.only(left: 25.h),
                  decoration: BoxDecoration(
                      color: Colors.green[300]!.withOpacity(.5),
                      borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(10),
                          topStart: Radius.circular(10),
                          bottomStart: Radius.circular(10))),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.messageModel!.text == null
                          ? InkWell(
                              onTap: () async {
                                print("Clicked");
                                print("index Click :${widget.index}");

                                print("Model ${widget.messageModel}");
                                Provider.of<ChattingController>(context)
                                    .downloadDocuments(
                                        url: "${widget.messageModel!.docsUrl}",
                                        fileName:
                                            "${widget.messageModel!.docsName}");

                                print("Download is done");
                              },
                              child: Row(children: [
                                Expanded(
                                  child: MyText(
                                    text: "${widget.messageModel!.docsName}",
                                    fontSize: 15.sp,
                                  ),
                                )
                              ]),
                            )
                          //* spicail to text
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MyText(
                                  text: "${widget.messageModel!.text}",
                                  fontSize: 15.sp,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                MyText(
                                  text: DateFormat('h:m a').format(
                                      DateTime.parse(
                                          widget.messageModel!.dateTime!)),
                                  fontSize: 8.sp,
                                )
                              ],
                            )),
                )

              //* spicail to image
              : widget.messageModel!.image != null
                  ? Container(
                      width: 60.w,
                      // height: 30.h,
                      decoration: const BoxDecoration(
                          // color: Colors.green[300]!.withOpacity(.5),
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(10),
                              topStart: Radius.circular(10),
                              bottomStart: Radius.circular(10))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierColor: Colors.black12
                                    .withOpacity(0.6), // Background color
                                barrierDismissible: false,
                                barrierLabel: 'Dialog',
                                transitionDuration: Duration(milliseconds: 400),
                                pageBuilder: (_, __, ___) {
                                  return Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 5,
                                        child: MaterialApp(
                                          debugShowCheckedModeBanner: false,
                                          builder: (context, child) {
                                            return Scaffold(
                                              extendBodyBehindAppBar: true,
                                              appBar: AppBar(
                                                backgroundColor: AppColor.black
                                                    .withAlpha(200),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    MyText(
                                                      text:
                                                          "${Provider.of<UserController>(context).myData!.name}",
                                                      fontSize: 15.sp,
                                                    ),
                                                    MyText(
                                                      text: DateFormat('h:m a')
                                                          .format(DateTime
                                                              .parse(widget
                                                                  .messageModel!
                                                                  .dateTime!)),
                                                      fontSize: 8.sp,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              body: Container(
                                                color: Colors.amber,
                                                height: double.infinity,
                                                child: PhotoView(
                                                  imageProvider: NetworkImage(
                                                    "${widget.messageModel!.image}",
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              ;
                              print("object");
                            },
                            child: Image(
                              image:
                                  NetworkImage("${widget.messageModel!.image}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          MyText(
                            text: DateFormat('h:m a').format(
                                DateTime.parse(widget.messageModel!.dateTime!)),
                            fontSize: 8.sp,
                          )
                        ],
                      ),
                    )
                  //* spicail to record message
                  : Container(
                      width: 60.w,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.green[300]!.withOpacity(.5),
                          borderRadius: const BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(10),
                              topStart: Radius.circular(10),
                              bottomStart: Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  String? uri =
                                      "${widget.messageModel!.record}";
                                  setState(() {
                                    isPlay = !isPlay;
                                  });
                                  if (isPlay == false) {
                                    audioPlayer.pause();
                                  } else {
                                    audioPlayer.play(UrlSource(uri));
                                  }
                                  print(isPlay);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.green[700],
                                  child: isPlay
                                      ? const Icon(Icons.pause)
                                      : const Icon(Icons.play_arrow),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      //* remove padding from slider
                                      overlayShape:
                                          SliderComponentShape.noThumb,
                                      // trackHeight: 2.0,
                                      thumbColor: Colors.green,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 0.sp),
                                    ),
                                    child: Slider(
                                      min: 0,
                                      max: duration.inSeconds.toDouble(),
                                      value: position.inSeconds.toDouble(),
                                      thumbColor: Colors.green,
                                      activeColor: Colors.green[900],
                                      onChanged: (value) {
                                        final position =
                                            Duration(seconds: value.toInt());
                                        audioPlayer.seek(position);
                                        audioPlayer.resume();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  // MyText(
                                  //     text: formatTime(
                                  //         (duration - position).inSeconds),
                                  //     fontSize: 10.sp),
                                  MyText(
                                      text: transformString(
                                          (duration - position).inSeconds),
                                      fontSize: 10.sp),
                                ],
                              )
                            ],
                          ),
                          // const Spacer(),

                          SizedBox(
                            height: 1.h,
                          ),
                          MyText(
                            text: DateFormat('h:m a').format(
                                DateTime.parse(widget.messageModel!.dateTime!)),
                            fontSize: 8.sp,
                          ),
                        ],
                      ),
                    )),
    );
  }
}
