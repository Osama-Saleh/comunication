// ignore_for_file: public_member_api_docsUrl, sort_constructors_first
class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? image;
  String? record;
  String? docsUrl;
  String? docsName;
  String? docsLocation;
  String? seen;
  int? progress;
  bool? onceRecordPlaying = true;
  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.image,
    this.record,
    this.docsUrl,
    this.docsName,
    this.docsLocation,
    this.seen,
    this.progress,
    this.onceRecordPlaying,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'image': image,
      'record': record,
      'docsUrl': docsUrl,
      'docsName': docsName,
      'docsLocation': docsLocation,
      'seen': seen,
      'progress': progress,
      'onceRecordPlaying': onceRecordPlaying,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      dateTime: map['dateTime'],
      text: map['text'],
      image: map['image'],
      record: map['record'],
      docsUrl: map['docsUrl'],
      docsName: map['docsName'],
      docsLocation: map['docsLocation'],
      seen: map['seen'],
      progress: map['progress'],
      onceRecordPlaying: map['onceRecordPlaying'],
    );
  }
}
