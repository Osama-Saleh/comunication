// ignore_for_file: must_be_immutable, avoid_print, sized_box_for_whitespace

import 'package:audioplayers/audioplayers.dart';
import 'package:communication/chatting/controller/chatting_controller.dart';
import 'package:communication/chatting/model/message_model.dart';
import 'package:communication/components/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ReceiveMessage extends StatefulWidget {
  ReceiveMessage({super.key, this.messageModel, this.index});
  MessageModel? messageModel;
  int? index;

  @override
  State<ReceiveMessage> createState() => _ReceiveMessageState();
}

class _ReceiveMessageState extends State<ReceiveMessage> {
  final audioPlayer = AudioPlayer();

  bool isPlay = false;

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return "${Duration(seconds: seconds)}".split(".")[0].padLeft(8, "0");
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
    
    // print("${widget.messageModel!.receiverId}");
    //* chick folder staus (faild - completed - run -......)
    // IsolateNameServer.registerPortWithName(
    //     port.sendPort, 'downloader_send_port');
    // print("logprogress: ${widget.index}");

    // port.listen((dynamic data) {
    // print("Myprogress");

    //   print("iiiiii : ${widget.index}");
    //   print("lllll : ${data.toString()}");

    // setState(() {
    //   progress = data[2];
    // });
    // print("progress : $progress");

    // ChattingCubit.get(context).prog = data[2];

    // ChattingCubit.get(context)
    //     .changeProgress(model: widget.messageModel, prog: data[2]);
    // print("progress : ${ChattingCubit.get(context).prog}");
    // print("progress${ChattingCubit.get(context).prog}");
    // });

    // FlutterDownloader.registerCallback(downloadCallback);
  }

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
              child: widget.messageModel!.text != null
                  //* spicail to text
                  ? Container(
                      // margin: EdgeInsets.only(left: 10.h),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(10),
                              topEnd: Radius.circular(10),
                              bottomStart: Radius.circular(10))),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: widget.messageModel!.text == null
                              ?
                              //* spicail to documents
                              InkWell(
                                  onTap: () async {
                                    print("Clicked");
                                    print("index Click :${widget.index}");

                                    print("Model ${widget.messageModel}");
                                    Provider.of<ChattingController>(context)
                                        .downloadDocuments(
                                            url:
                                                "${widget.messageModel!.docsUrl}",
                                            fileName:
                                                "${widget.messageModel!.docsName}");

                                    print("Download is done");
                                  },
                                  child: Row(children: [
                                    Expanded(
                                      child: MyText(
                                        text:
                                            "${widget.messageModel!.docsName}",
                                        fontSize: 15.sp,
                                      ),
                                    )
                                  ]),
                                )
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
                                    ),
                                  ],
                                )),
                    )

                  //* spicail to image
                  : widget.messageModel!.image != null
                      ? Container(
                          width: 60.w,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5),
                              borderRadius: const BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(10),
                                  topStart: Radius.circular(10),
                                  bottomStart: Radius.circular(10))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: PhotoView(
                                            imageProvider: NetworkImage(
                                              "${widget.messageModel!.image}",
                                            ),
                                          ));
                                    },
                                  );
                                  print("object");
                                },
                                child: Image(
                                  image: NetworkImage(
                                      "${widget.messageModel!.image}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              MyText(
                                text: DateFormat('h:m a').format(DateTime.parse(
                                    widget.messageModel!.dateTime!)),
                                fontSize: 8.sp,
                              ),
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
                                  topEnd: Radius.circular(10),
                                  bottomStart: Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            final position = Duration(
                                                seconds: value.toInt());
                                            audioPlayer.seek(position);
                                            audioPlayer.resume();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      MyText(
                                          text: formatTime(
                                              (duration - position).inSeconds),
                                          fontSize: 10.sp),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              MyText(
                                text: DateFormat('h:m a').format(DateTime.parse(
                                    widget.messageModel!.dateTime!)),
                                fontSize: 8.sp,
                              ),
                            ],
                          ),
                        )),
        ),
      ),
    );
  }
}
