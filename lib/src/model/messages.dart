import '../helper/helper_class.dart';

class MessagesChat {
  final String idFrom;
  final String idTo;
  final String timeStamp;
  final String content;
  final String videothumbnail;
  final String filename;
  final int type;

  const MessagesChat(
      {required this.idFrom,
      required this.idTo,
      required this.timeStamp,
      required this.content,
      required this.videothumbnail,
      required this.filename,
      required this.type});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> messageModelMap = {};
    messageModelMap[FirebaseKeys.fromId] = idFrom;
    messageModelMap[FirebaseKeys.toId] = idTo;
    messageModelMap[FirebaseKeys.timestamp] = timeStamp;
    messageModelMap[FirebaseKeys.content] = content;
    messageModelMap[FirebaseKeys.videothumbnail] = videothumbnail;
    messageModelMap[FirebaseKeys.filename] = filename;
    messageModelMap[FirebaseKeys.type] = type;
    return messageModelMap;
  }

  factory MessagesChat.fromMap(Map<dynamic, dynamic> json) => MessagesChat(
      idFrom: json[FirebaseKeys.fromId],
      idTo: json[FirebaseKeys.toId],
      timeStamp: json[FirebaseKeys.timestamp],
      content: json[FirebaseKeys.content],
      videothumbnail: json[FirebaseKeys.videothumbnail] ?? '',
      filename: json[FirebaseKeys.filename],
      type: json[FirebaseKeys.type]);
}
