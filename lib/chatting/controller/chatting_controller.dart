// ignore_for_file: avoid_print, await_only_futures, unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communication/chatting/model/message_model.dart';
import 'package:communication/components/const.dart';
// import 'package:communication/core/hive_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ChattingController extends ChangeNotifier {
  final audioPlayer = AudioPlayer();

  bool isPlay = false;

  Duration duration = Duration.zero;

  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return "${Duration(seconds: seconds)}".split(".")[0].padLeft(8, "0");
  }

  // void onPlayerStateChanged() {
  //   audioPlayer.onPlayerStateChanged.listen((state) {
  //     isPlay = state == PlayerState.playing;
  //   });
  // }

  void onDurationChanged() {
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });
  }

  void onPositionChanged() {
    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;

      notifyListeners();
    });
  }

  void isPlayRecord() {
    isPlay = !isPlay;
    notifyListeners();
  }

  ScrollController scrollController = ScrollController();
  var formKey = GlobalKey<FormState>();
  bool isEmojiSelected = false;
  void selectEmoji() {
    isEmojiSelected = !isEmojiSelected;
    notifyListeners();
  }

  //*=============================================
  //?=======  save messages in firebase =========
  //*=============================================
  Future<void> sendMessage({
    String? receiverId,
    String? text,
    String? dateTime,
    String? image,
    String? record,
    String? docsUrl,
    String? docsName,
    String? docsLocation,
  }) async {
    print("send notify loadin");
    MessageModel messageModel = MessageModel(
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
      senderId: MyConst.uidUser,
      image: image,
      record: record,
      docsUrl: docsUrl,
      docsName: docsName,
      docsLocation: docsLocation,
    );
    //* my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(MyConst.uidUser)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      print("send notify succ");
      notifyListeners();
    }).catchError((onError) {
      print("send notify Error");
    });
    //* receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection("Chats")
        .doc(MyConst.uidUser)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      print("send notify succ");
      notifyListeners();
    }).catchError((onError) {
      print("send notify Error");
    });
  }

  //*==============================================================
  //*      get messages from firebase to message model
  //*==============================================================
  List<MessageModel>? messages = [];
  bool messageLoaded = false;

  // void resetMessages() {
  //   messages = [];
  //   notifyListeners();
  // }

  Future<void> getMessage({
    String? receiverId,
  }) async {
    messageLoaded = false;
    print("getMessage notify Loading");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(MyConst.uidUser)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      messages = [];

      for (var element in event.docs) {
        messages!.add(MessageModel.fromJson(element.data()));
      }
      messageLoaded = true;
      print("lalalammm ${messages}");
      print("getMessage notify Succ");
      notifyListeners();
    });
  }

//*=======================================================================
//*                      get image from device
//*=======================================================================
  File? selectImage;
  ImagePicker sendpicker = ImagePicker();

  Future setSelectImage({String? receiverId}) async {
    print("SelectImage notify loading");
    final imagefile = await sendpicker.pickImage(source: ImageSource.gallery);

    if (imagefile != null) {
      selectImage = File(imagefile.path);
      print("image Path is : ${selectImage}");

      uploadImage(receiverId: receiverId);
      notifyListeners();
      print("SelectImage notify secc");
    } else {
      print("Not Image Selected");
    }
  }

//*=======================================================================
//*                       upload image in firebase
//*=======================================================================
  String? image;
  Future<void> uploadImage({String? receiverId}) async {
    print("uploadImage notify laodubg");
    FirebaseStorage.instance
        .ref("images/${Uri.file(selectImage!.path).pathSegments.last}")
        .putFile(selectImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //? value => paht url
        print("Image Url $value");
        notifyListeners();

        sendMessage(
          receiverId: receiverId,
          image: value,
          dateTime: DateTime.now().toString(),
        );
      }).catchError((onError) {
        print("UploadImageError : $onError");
      });
    }).catchError((onError) {
      print("UploadImageError: $onError");
    });
  }

  //*===========================================================================
  //*                          record
  //*===========================================================================
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  bool isChangeHintText = false;
  String? hintText = "Message";

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Microphone Permission not granted";
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: "audio${DateTime.now().millisecond}");
    print("RecordMessageSuccess");
    notifyListeners();
  }

  bool isMice = false;
  void changeMice() {
    isMice = !isMice;
    notifyListeners();
  }

  TextEditingController messageController = TextEditingController();
  void textEditController() {
    messageController = messageController;
    notifyListeners();
  }

  //*======================================================
  //*                   reset time of record
  //*======================================================
  Future<void> resetRecord() async {
    print("Done Record");
    secondTime = 0;
    minutesTime = 0;
    messageController.text = "";

    isChangeHintText = false;

    print(
        'time => ${secondTime! + minutesTime!}  message => ${messageController.text.trim().isEmpty}');
    notifyListeners();
  }

  File? audioFile;
  Future stop({
    String? receiverId,
  }) async {
    //* Uri.file(selectImage!.path).pathSegments.last}
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    audioFile = File(path!);
    print("audioFile $audioFile");
    secondTime = 0;
    minutesTime = 0;
    voiceSave(receiverId: receiverId);
    // uploadAudio(path, receiverId!);
  }

  //*===========================================================================
  //*                          time Record
  //*===========================================================================

  int? secondTime = 0;
  int? minutesTime = 0;
  int timeRecord() {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        secondTime = secondTime! + 1;
        notifyListeners();
        if (secondTime == 10) {
          minutesTime = minutesTime! + 1;
          secondTime = 0;
          print("60 seconds");
          notifyListeners();
        }
        if (isChangeHintText == false) timer.cancel();
      },
    );
    print("TimeRecordChange Succ");
    return secondTime!;
  }

  //*===========================================================================
  //*                      play record sound
  //*===========================================================================
  bool showPlay = false;

  AssetsAudioPlayer player = AssetsAudioPlayer();
  Future initplayer({String? path}) async {
    player.open(Audio("$path"), autoStart: false, showNotification: true);
    showPlay = !showPlay;
    notifyListeners();
    print("PlayRecord succ");
  }
//!============================================================================
//!     save recorod sound another way
  // final Reference storageReference =
  //     FirebaseStorage.instance.ref().child('audio');
//* from GPT
// Upload audio file to Firebase Storage
  // var downloadURL;
  // Future<void> uploadAudio(String path, String receiverId) async {
  //   final file = File(path);
  //   final uploadTask =
  //       storageReference.child('${DateTime.now()}.mp3').putFile(file,
  //       //! May be use it or not
  //       SettableMetadata(contentType: 'audio/wav')
  //       );
  //   final snapshot = await uploadTask.whenComplete(() {
  //     // sendMessage(
  //     //   dateTime: DateTime.now().toString(),
  //     //   receiverId: receiverId,
  //     //   record: path
  //     // );
  // emit(UploadRecordSuccessState());
  // print("UploadRecordSuccessState");
  //   });

  //   if (snapshot.state == TaskState.success) {
  //     downloadURL = await snapshot.ref.getDownloadURL().whenComplete(() {
  //       print("downloadURL $downloadURL");
  //       // sendMessage(
  //       //   dateTime: DateTime.now().toString(),
  //       //   receiverId: receiverId,
  //       //   record: downloadURL,
  //       // );
  //     });
  //     // return downloadURL;
  //   } else {
  //     throw 'Audio upload failed';
  //   }
  // }
//!============================================================================
  //*=======================================================================
  //*                      save record in firebase
  //*=======================================================================
  String? audioUrl;
  Future<void> voiceSave({String? receiverId}) async {
    print("SaveRecordLoading");
    FirebaseStorage.instance
        .ref("records/${Uri.file(audioFile!.path).pathSegments.last}.mp3")
        .putFile(audioFile!, SettableMetadata(contentType: 'audio/wav'))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //? value => paht url
        print("value url  ${value}");
        print("SaveRecord Succ");

        audioUrl = "${value}.mp3";
        sendMessage(
          receiverId: receiverId,
          record: audioUrl,
          dateTime: DateTime.now().toString(),
        );

        notifyListeners();
      }).catchError((onError) {
        notifyListeners();
        print("SaveRecord Error");
      });
    }).catchError((onError) {
      notifyListeners();
      print("SaveRecord Error");
    });
  }

  //*=======================================================================
  //*                      send docs <pdf,word,files>
  //*=======================================================================

  String? filePath;
  String? fileName;
  Future selectDocuments({String? receiverId}) async {
    print("SelectDocumentsNotifyLoading");
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile? file = result.files.first;
      print("name file ${result}");

      // fileName!.add("${result.names.first}");
      print("fileNames : ${result.names.first}");
      fileName = result.names.first;
      filePath = file.path;
    }

    print("filePath $filePath");
    FirebaseStorage.instance
        .ref("docs/${result!.names.first}")
        .putFile(File(filePath!))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //?===========================================================
        //?                 value => paht url of file
        //?===========================================================
        print("Document url  ${value}");

        sendMessage(
          receiverId: receiverId,
          docsUrl: value,
          docsName: result.names.first,
          dateTime: DateTime.now().toString(),
        );
        notifyListeners();
        print("SelectDocumentsSuccessState");
        // downloadDocuments(url: value, fileName: fileName);
      }).catchError((onError) {
        print("SelectDocumentsError : $onError");
      });
    }).catchError((onError) {
      print("SelectDocumentsError : $onError");
    });
  }

  //*=======================================================================
  //*                      download file Documents
  //*=======================================================================
  String? externalDir;
  List<String> docsLocation = [];

  Future downloadDocuments(
      {required String url, required String? fileName}) async {
    print("DownloadDocumentsLoading");

    final status = await Permission.storage.request();

    if (status.isGranted) {
      // final filPaht = await getExternalStorageDirectory();
      final directory = await getApplicationDocumentsDirectory();
      final filaPath = File("${directory.path}/$fileName");

      // externalDir = "${filPaht}${fileName}";

      // print("filePaht : ${filPaht.exists()}");
      print("filePaht : ${filaPath}");

      print("externalDir1 $externalDir");

      await FlutterDownloader.enqueue(
        url: url,
        savedDir: filaPath.path,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      ).whenComplete(() {
        print("externalDir2 : $externalDir");
        // CheckFileExit(externalDir: filaPath.path);
        // OpenFile.open("$externalDir");

        // print("urLFile : $url");
        // launchUrl(Uri.file(docsLocation[0]));
        // docsLocation.add(externalDir!);
      });
      print("docsLocation$docsLocation");
    } else {
      print('Permission Denied');
    }
  }

  bool fileExist = false;
  void CheckFileExit({String? externalDir}) async {
    print("externalDir3 : $externalDir");

    // bool fileChekExist = await File(externalDir!).exists();
    bool fileChekExist = await File("Internal storageDownload").exists();
    print("fileExist1 : $fileChekExist");
    // print("fileExist2 : $fileExist");
    // emit(CheckFileExitState());
    // print("CheckFileExitState");
  }
}
