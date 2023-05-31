// // // ignore_for_file: avoid_print

// // ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:telegram/components/widgets/my_text.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   final recorder = FlutterSoundRecorder();
//   bool isRecorderReady = false;

//   Future initRecorder() async {
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw "Microphone Permission not granted";
//     } 
//     await recorder.openRecorder();
//     isRecorderReady = true;
//     recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
//   }

//   Future record() async {
//     if (!isRecorderReady) return;
//     await recorder.startRecorder(toFile: "audio${DateTime.now().millisecond}");
//   }

//   Future stop() async {
//     if (!isRecorderReady) return;
//     final path = await recorder.stopRecorder();
//     final audioFile = File(path!);
//     print("recording $audioFile");
//   }

//   @override
//   void initState() {
//     super.initState();
//     initRecorder();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     recorder.closeRecorder();
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           StreamBuilder(
//             stream: recorder.onProgress,
//             builder: (context, snapshot) {
//               final duraton =
//                   snapshot.hasData ? snapshot.data!.duration : Duration.zero;

//               String twoDigits(int n) => n.toString().padLeft(0);
//               final twoDigitsMinutes =
//                   twoDigits(duraton.inMinutes.remainder(60));
//               final twoDigitsSeconds =
//                   twoDigits(duraton.inSeconds.remainder(60));

//               return MyText(
//                 text: "${twoDigitsMinutes} : $twoDigitsSeconds",
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               );
//             },
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 if (recorder.isRecording) {
//                   await stop();
//                 } else {
//                   await record();
//                 }
//                 setState(() {});
//               },
//               child: recorder.isRecording ? Icon(Icons.stop) : Icon(Icons.mic)),
//         ],
//       ),
//     )
        

//         );
//   }
// }


